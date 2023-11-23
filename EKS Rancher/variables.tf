#Pre configs
variable "prefix" {}
variable "cluster_name" {}
variable "retention_days" {}
variable "aws_region" {}
variable "kubeconfig_path" {}
#Scaling node groups
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}

#Subnets
variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Subnet CIDR values"
 default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

#Two AZ default for EKS
variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b"]
}

#Rancher version
variable "rancher_version" {
  type        = string
  description = "Rancher version"
  default     = "2.7.8"
}

#Helm repo
variable "rancher_helm_repository" {
  type        = string
  description = "Rancher Helm Repository"
  default     = "https://releases.rancher.com/server-charts/latest"
}

#EKS version
variable "eks_version" {
  type        = string
  description = "EKS version"
  default     = "1.26"
}