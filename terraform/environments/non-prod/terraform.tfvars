# General
aws_region   = "us-east-1"
project_name = "ec2-servers"
owner        = "DevOps"
cost_center  = "IT-Infrastructure"

# VPC
vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.10.0/24", "10.1.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# Security
ssh_allowed_cidrs   = ["10.0.0.0/8"]
rdp_allowed_cidrs   = ["10.0.0.0/8"]
winrm_allowed_cidrs = ["10.0.0.0/8"]

# Linux Server
linux_instance_type    = "t3.micro"
linux_private_ip       = "10.1.1.10"
linux_assign_eip       = true
linux_root_volume_size = 30

# Windows Server
windows_instance_type    = "t3.small"
windows_private_ip       = "10.1.2.10"
windows_assign_eip       = true
windows_root_volume_size = 50

# Common
key_name = "ec2-key-pair-non-prod"
