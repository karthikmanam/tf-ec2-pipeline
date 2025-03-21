variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "ec2-servers"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "DevOps"
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
  default     = "IT-Infrastructure"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.1.10.0/24", "10.1.11.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Security Configuration
variable "ssh_allowed_cidrs" {
  description = "List of CIDR blocks allowed to SSH to Linux server"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "rdp_allowed_cidrs" {
  description = "List of CIDR blocks allowed to RDP to Windows server"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "winrm_allowed_cidrs" {
  description = "List of CIDR blocks allowed to use WinRM to Windows server"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

# EC2 Configuration - Linux

variable "linux_instance_type" {
  description = "Instance type for the Linux server"
  type        = string
  default     = "t3.small"  # Bigger instance for production
}

variable "linux_private_ip" {
  description = "Private IP for the Linux server (optional)"
  type        = string
  default     = "10.1.10.10"
}

variable "linux_assign_eip" {
  description = "Whether to assign an Elastic IP to the Linux server"
  type        = bool
  default     = false  # Using private subnet, so no EIP needed
}

variable "linux_root_volume_size" {
  description = "Size of the root volume for the Linux server in GB"
  type        = number
  default     = 50  # More space for production
}

# EC2 Configuration - Windows
variable "windows_instance_type" {
  description = "Instance type for the Windows server"
  type        = string
  default     = "t3.medium"  # Bigger instance for production
}

variable "windows_private_ip" {
  description = "Private IP for the Windows server (optional)"
  type        = string
  default     = "10.1.11.10"
}

variable "windows_assign_eip" {
  description = "Whether to assign an Elastic IP to the Windows server"
  type        = bool
  default     = false  # Using private subnet, so no EIP needed
}

variable "windows_root_volume_size" {
  description = "Size of the root volume for the Windows server in GB"
  type        = number
  default     = 100  # More space for production
}

# Common
variable "key_name" {
  description = "Name of the key pair to use for SSH/RDP access"
  type        = string
  default     = "ec2-key-pair-prod"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
  
}