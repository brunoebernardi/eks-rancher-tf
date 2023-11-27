# Base repository for deploying Rancher on AWS using Terraform

## About The Project

This repository uses EKS terraform templates and modules to deploy Rancher on AWS. The main objective is to provide a simple and fast way of deploying Rancher on AWS for troubleshooting and generating test environments to approximate customer environments and carry out simulations. Most of the codebase is using HCL(Hashicorp Configuration Language).


## Prerequisites
   
1. Terraform should be installed on your local or remote computer where the repository is cloned. Please refer [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) for installation instructions.

2. For Terraform to run operations on your behalf, you must install and configure the AWS CLI tool. Please refer [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions) for installation instructions.

3. AWS IAM should be installed and configured to provide correct authentication on the EKS cluster. Please refer [here](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) for installation instructions.

4. Git should be installed on the local or remote computer that is used for cloning the repository, as mentioned above. Please refer to the git installation guide [here](https://github.com/git-guides/install-git).
   
5. Kubectl should be installed on the local or remote computer, which is used to access and manipulate a Kubernetes environment. Please refer [here](https://kubernetes.io/docs/tasks/tools/) for installation instructions.



## Getting Started

To get started, you can clone the git repository to a desired location in your local or remote computer:

git clone git@github.com:brunoebernardi/eks-rancher-tf.git
