#Role to ec2 instances
resource "aws_iam_role" "node" {
  name = "${var.prefix}-${var.cluster_name}-role-node"
   assume_role_policy = <<POLICY
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Principal": {
         "Service": "ec2.amazonaws.com"
       },
       "Action": "sts:AssumeRole"
     }
   ]
}
   POLICY
}


#Worker nodes policy
resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  role = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

#EKS Node communication policy
resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  role = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

#Policy for registry resources on AWS
resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  role = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.node.name
}

#EKS NodeGroup
resource "aws_eks_node_group" "node-1" {
  cluster_name = aws_eks_cluster.k8scluster.name
  node_group_name = "node-1"
  node_role_arn = aws_iam_role.node.arn
  subnet_ids = aws_subnet.subnets[*].id 
  instance_types = ["t3.medium"]
  scaling_config {
    desired_size = var.desired_size
    max_size = var.max_size
    min_size = var.min_size
  }
    depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}