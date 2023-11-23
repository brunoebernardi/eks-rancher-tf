# Before executing
2. Set your kubeconfig path in variable kubeconfig_path on terraform.tfvars file - Example: /Users/brunobernardi/.kube/config
3. Run -> export KUBE_CONFIG_PATH=<location-config-file>
4. Set your AWS Keys in providers.tf file and ".aws/credentils" in your user home:
[default]
aws_access_key_id=
aws_secret_access_key=
5. To change Rancher or EKS Version, use variables.tf file

# Execution
1. terraform init ; terraform plan
2. terraform apply
3. You can change the type of Rancher Service to NodePort or ClusterIP
  

# Destroy
1. terraform state rm helm_release.rancher_server
2. terraform destroy -auto-approve

NOTE: For Network issues, before terraform deletes EKS cluster, if the internet gateway and subnets are not removed within 8 minutes, manually remove LB and SG ELB on AWS Console or AWS CLI