locals {
  common_tags = {
    "cloud/platform" = "AWS"
    "cloud/platform_env" = var.env
    "cloud/managed_by" = "terraform"
    "cloud/module" = "launch_template"
  }

  userdata = <<-USERDATA
  #!/bin/bash
  set -o xtrace
  /etc/eks/bootstrap.sh --apiserver-endpoint '${var.apiserver_endpoint}' --b64-cluster-ca '${var.cluster_ca}' --use-max-pods false '${var.eks_cluster_name}'
  USERDATA

/*
  userdata = <<-USERDATA
  #!/bin/bash
  set -o xtrace
  /etc/eks/bootstrap.sh --apiserver-endpoint '${data.aws_eks_cluster.this.endpoint}' --b64-cluster-ca '${data.aws_eks_cluster.this.certificate_authority.0.data}' --use-max-pods false --kubelet-extra-args '--node-labels=${join(",",[for k,v in local.common_tags : format("%s=%s", k, v)])} --max-pods=${var.max_pods}' '${var.cluster_name}'
  USERDATA
*/
}
