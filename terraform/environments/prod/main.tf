locals {
  environment = var.environment
  common_tags = {
    Environment  = local.environment
    Project      = var.project_name
    ManagedBy    = "terraform"
    Owner        = var.owner
    CostCenter   = var.cost_center
  }
}

# Generate random string as unique identifier (useful for resources that need unique names)
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# VPC and Networking
module "vpc" {
  source = "../../modules/vpc"

  environment          = local.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = local.common_tags
}

# Security
module "security" {
  source = "../../modules/security"

  environment        = local.environment
  vpc_id             = module.vpc.vpc_id
  ssh_allowed_cidrs  = var.ssh_allowed_cidrs
  rdp_allowed_cidrs  = var.rdp_allowed_cidrs
  winrm_allowed_cidrs = var.winrm_allowed_cidrs
  tags               = local.common_tags
}


# Write rendered templates to files
resource "local_file" "linux_cloud_init_file" {
  content  = templatefile("../../cloud-init/linux-init.yaml", { environment = local.environment, hostname = "${local.environment}-linux-server" })
  filename = "${path.module}/rendered/linux-cloud-init.yaml"
}

resource "local_file" "windows_cloud_init_file" {
  content  = templatefile("../../cloud-init/windows-init.ps1", { environment = local.environment, hostname = "${local.environment}-windows-server" })
  filename = "${path.module}/rendered/windows-cloud-init.ps1"
}

# EC2 Instances
module "ec2" {
  source = "../../modules/ec2"

  environment = local.environment
  
  # Linux Server
  linux_instance_type      = var.linux_instance_type
  linux_subnet_id          = module.vpc.private_subnet_ids[0]  # Note: Using private subnet for prod
  linux_security_group_id  = module.security.linux_security_group_id
  linux_private_ip         = var.linux_private_ip
  linux_assign_eip         = var.linux_assign_eip
  linux_root_volume_size   = var.linux_root_volume_size
  linux_cloud_init_file    = file(local_file.linux_cloud_init_file.filename)
  
  # Windows Server
  windows_instance_type      = var.windows_instance_type
  windows_subnet_id          = module.vpc.private_subnet_ids[1]  # Note: Using private subnet for prod
  windows_security_group_id  = module.security.windows_security_group_id
  windows_private_ip         = var.windows_private_ip
  windows_assign_eip         = var.windows_assign_eip
  windows_root_volume_size   = var.windows_root_volume_size
  windows_cloud_init_file    = file(local_file.windows_cloud_init_file.filename)
  
  # Common
  key_name               = var.key_name
  instance_profile_name  = module.security.instance_profile_name
  tags                   = local.common_tags
}
