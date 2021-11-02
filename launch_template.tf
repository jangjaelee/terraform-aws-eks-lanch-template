resource "aws_launch_template" "this" {
  name            = var.lt_name
  description     = var.lt_description
  #default_version = var.lt_version
  
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  vpc_security_group_ids = var.sg_ids
  
  block_device_mappings {
    device_name = var.device_name
    
    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
      
      
      encrypted   = true
      #kms_key_id  = var.kms_arn_ebs
      delete_on_termination = true
    }
  }
  
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
  }
  
  user_data = base64encode(local.userdata)
  
  tag_specifications {
  	resource_type = "instance"
  
    tags = merge(
      {
        "Name" = format("%s-lt", var.lt_name)
      },
      local.common_tags,
    )
  }
}
