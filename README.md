# AWS Launch Template for EKS Worker Node Terraform module

Terraform module which creates Launch Template for EKS Worker Node resources on AWS.

These types of resources are supported:

* [Launch Template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)


## Usage
### Launch Template

main.tf
```hcl
module "launch_template" {
  source = "git@github.com:jangjaelee/terraform-aws-eks-launch-template.git"

  lt_name        = "${local.cluster_name}-CentOS-7_AMI"
  lt_description = "CenOS 7 AMI launch template"
  ami_id         = "ami-0e4214f08b51e23cc" // CentOS Linux 7 / 7.9.2009 / ap-northeast-2 / X86_64

  instance_type  = "t3.2xlarge" 
  key_name       = local.cluster_name
  sg_ids         = ["sg-0912d9fe44bd"] // Security Group for EKS nodes (bastion and eks remoteAccess)

  eks_cluster_name = local.cluster_name
  apiserver_endpoint = ""  // EKS API Endpoint
  cluster_ca = "" // EKS Cluster CA

  device_name = "/dev/xvda"
  volume_size = 30
  volume_type = "gp2"

  #kms_arn_eks = ""
  #kms_arn_ebs = "arn:aws:kms:ap-northeast-2:000000000000:key/ecd396bc-d17a-437a-bcc0-de0a595dca26"
  
  env = "dev"
}
```

locals.tf
```hcl
locals {
  vpc_name = "KubeSphere-dev"
  cluster_name = "KubeSphere-v121-dev"
  cluster_version = "1.21"
}
```

providers.tf
```hcl
provider "aws" {
  version = ">= 3.2.0"
  region = var.region
  allowed_account_ids = var.account_id
  profile = "eks_service"
}
```

terraform.tf
```hcl
terraform {
  required_version = ">= 0.13.0"

  backend "s3" {
    bucket = "kubesphere-terraform-state-backend"
    key = "kubesphere/eks-launch-template/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "kubesphere-terraform-state-locks"
    encrypt = true
    profile = "eks_service"
  }
}
```

variables.tf
```hcl
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "account_id" {
  description = "List of Allowed AWS account IDs"
  type        = list(string)
  default     = ["123456789012"]
}
```
