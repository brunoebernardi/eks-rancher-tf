#SG EGRESS
resource "aws_security_group" "k8s-sg" {
  vpc_id     = aws_vpc.nem-vpc.id
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      prefix_list_ids  = []
  }
    tags = {
       Name = "${var.prefix}-k8s-sg"
  }
}

#Access cluster policies
resource "aws_iam_role" "k8scluster" {
   name = "${var.prefix}-${var.cluster_name}-role"
   assume_role_policy = <<POLICY
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Principal": {
         "Service": "eks.amazonaws.com"
       },
       "Action": "sts:AssumeRole"
     }
   ]
}
   POLICY
}

resource "aws_iam_role_policy_attachment" "k8scluster-AmazonEKSVPCResourceController" {
  role = aws_iam_role.k8scluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}


resource "aws_iam_role_policy_attachment" "k8scluster-AmazonEKSClusterPolicy" {
  role = aws_iam_role.k8scluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

##Logs
resource "aws_cloudwatch_log_group" "log" {
  name = "/aws/eks${var.prefix}-${var.cluster_name}/cluster"
  retention_in_days = var.retention_days
}

##EKS Configs
resource "aws_eks_cluster" "k8scluster" {
  name = "${var.prefix}-${var.cluster_name}"
  version = "${var.eks_version}"
  role_arn = aws_iam_role.k8scluster.arn
  enabled_cluster_log_types = ["api","audit"]
  ##Associate cluster on VPC
  vpc_config {
    subnet_ids = aws_subnet.subnets[*].id
    security_group_ids = [aws_security_group.k8s-sg.id]

  }
  depends_on = [
    aws_cloudwatch_log_group.log,
    aws_iam_role_policy_attachment.k8scluster-AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.k8scluster-AmazonEKSClusterPolicy,
  ]
}
