# Before executing
1. Customize your preferences on "terraform.tfvars & variables.tf file" for your EKS Cluster environment.
2. Customize your preferences on "k8s-rancher.tf file" for your Rancher environment.
3. Set kubeconfig path in variable kubeconfig_path on "terraform.tfvars file". After this, run export "KUBE_CONFIG_PATH=" to the destination.
4. Set your AWS Keys in providers.tf file and ".aws/credentials" in your user home.
##### NOTE: This terraform project supports different types of EKS and Rancher versions and is highly customizable depending on your requirements. You can customize subnets, network rules, VM types, number of nodes, autoscaling, and logs for the cluster. Please see the description and comments on the code for a better understanding.



# Execution
1. Run on terminal: terraform init ; sleep 3 ; terraform plan ; terraform apply
2. The cluster will be accessible as declared in "KUBE_CONFIG_PATH" and you can run kubectl commands.
3. You can change the type of Rancher Service to NodePort or ClusterIP
  

# Destroy
1. Run on terminal: terraform state rm helm_release.rancher_server
2. Run on terminal: terraform destroy -auto-approve
##### NOTE: For Network issues, before Terraform deletes the EKS cluster, if the internet gateway and subnets are not removed within 8 minutes, manually remove LB and SG ELB on AWS Console or AWS CLI.
