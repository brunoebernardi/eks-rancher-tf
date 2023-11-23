#Create and save kubeconfig file
locals {
    depends_on = [
    aws_eks_node_group.node-1,
    aws_eks_cluster.k8scluster,
  ]
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${aws_eks_cluster.k8scluster.certificate_authority[0].data}
    server: ${aws_eks_cluster.k8scluster.endpoint}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: ${aws_eks_cluster.k8scluster.name}
  name: ${aws_eks_cluster.k8scluster.name}
current-context: ${aws_eks_cluster.k8scluster.name}
kind: Config
preferences: {}
users:
- name: ${aws_eks_cluster.k8scluster.name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.k8scluster.name}"
KUBECONFIG
}

resource "local_file" "config" {
    filename = var.kubeconfig_path
    content = local.kubeconfig
}
