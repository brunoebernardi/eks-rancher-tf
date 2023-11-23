# Base repository for deploying Rancher on AWS & EKS using terraform

## About The Project

This repository is based on EKS terraform templates and modules for deploying Rancher on AWS. The main objective is to provide a simple and fast way of deploying Rancher on AWS for troubleshooting and generating test environments to approximate customer environments and carry out simulations. Most of the codebase is using HCL(Hashicorp Configuration Language).

This terraform project supports different types of EKS and Rancher versions and is highly customizable depending on your requirements. You can customize subnets, network rules, VM types, number of nodes, autoscalling and logs for the cluster. Please see the description for a better understanding.

## Prerequisites
   
1. Terraform should be installed on your local or remote computer where the repository is cloned. Please refer [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) for installation instructions.


2. In order for Terraform to run operations on your behalf, you must install and configure the AWS CLI tool. Please refer [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions) for instructions.

3. AWS IAM should be installed and configure to provide correct authentication on EKS cluster. Please refer [here] (https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

## Getting Started

To get started you can clone the git repository to a desired location in your local or remote computer:

git clone git@github.com:brunoebernardi/eks-rancher-tf.git