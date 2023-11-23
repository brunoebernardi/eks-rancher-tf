#Install Rancher
resource "helm_release" "rancher_server" {

  depends_on = [
    aws_eks_cluster.k8scluster,
  ]
  
  name             = "rancher"
  chart            = "${var.rancher_helm_repository}/rancher-${var.rancher_version}.tgz"
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true

  set {
    name  = "hostname"
    value = "rancher-support.aws.org"
  }

  set {
    name  = "tls"
    value = "external"
  }

  set {
    name  = "ingress.ingressClassName"
    value = "nginx"
  }

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "bootstrapPassword"
    value = "admin"
  }

    set {
    name  = "type"
    value = "LoadBalancer"
  }
}
