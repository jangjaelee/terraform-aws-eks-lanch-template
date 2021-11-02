variable "lt_name" {
  description = "Name to be used on all the resources as identifier for launch template"
  type        = string
  #default     = "CentOS-7_ap-northeast-2_AMI"
}

variable "lt_description" {
  description = "Description of the launch template"
  type        = string
  default     = "CIS hardening AMI launch template"
}

variable "lt_version" {
  description = "launch template version"
  type        = string
  default     = "v1"
}

variable "ami_id" {
  description = "The AMI from which to launch the instance"
  type        = string
  #default     = "ami-0e4214f08b51e23cc"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  #default     = "m5.xlarge"
}

variable "key_name" {
  description = "Kypair name for EC2"
  type        = string
  default     = "Terraform_Platform_EKS_Keypair"
}

variable "sg_ids" {
  description = "Security Group IDs"
  type        = list(string)
  #default     = ["sg-0912d9fe44bd"]
}

variable "eks_cluster_name" {
  description = "name of EKS cluster"
  type        = string
}

variable "apiserver_endpoint" {
  description = "Kubernetes API Server Endpoint"
  type        = string
}

variable "cluster_ca" {
  description = "Kubernetes cluster Certificate authority"
  type        = string
}

variable "device_name" {
  description = "The name of the device to mount"
  type        = string
  default     = "/dev/xvda"
}
    
variable "volume_size" {
  description = "The size of the volume in gigabytes" 
  type        = number
  default     = 30
}

variable "volume_type" {
  description = "The type of volume. (gp2, io1, io2, standard)"
  type        = string
  default     = "gp2"
}

variable "kms_arn_ebs" {
  description = "Amazon Resource Name (ARN) of the Key Management Service (KMS) customer master key (CMK)."
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
  #default     = "dev"
}