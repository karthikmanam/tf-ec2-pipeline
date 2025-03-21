variable "environment" {
  description = "Environment name"
  type        = string
}

variable "linux_instance_type" {
  description = "Instance type for the Linux server"
  type        = string
  default     = "t3.micro"
}

variable "linux_subnet_id" {
  description = "Subnet ID for the Linux server"
  type        = string
}

variable "linux_security_group_id" {
  description = "Security group ID for the Linux server"
  type        = string
}

variable "linux_private_ip" {
  description = "Private IP for the Linux server (optional)"
  type        = string
  default     = ""
}

variable "linux_assign_eip" {
  description = "Whether to assign an Elastic IP to the Linux server"
  type        = bool
  default     = false
}

variable "linux_root_volume_size" {
  description = "Size of the root volume for the Linux server in GB"
  type        = number
  default     = 30
}

variable "linux_root_volume_type" {
  description = "Type of the root volume for the Linux server"
  type        = string
  default     = "gp3"
}

variable "linux_cloud_init_file" {
  description = "Path to cloud-init file for the Linux server (optional)"
  type        = string
  default     = ""
}

variable "windows_instance_type" {
  description = "Instance type for the Windows server"
  type        = string
  default     = "t3.medium"
}

variable "windows_subnet_id" {
  description = "Subnet ID for the Windows server"
  type        = string
}

variable "windows_security_group_id" {
  description = "Security group ID for the Windows server"
  type        = string
}

variable "windows_private_ip" {
  description = "Private IP for the Windows server (optional)"
  type        = string
  default     = ""
}

variable "windows_assign_eip" {
  description = "Whether to assign an Elastic IP to the Windows server"
  type        = bool
  default     = false
}

variable "windows_root_volume_size" {
  description = "Size of the root volume for the Windows server in GB"
  type        = number
  default     = 50
}

variable "windows_root_volume_type" {
  description = "Type of the root volume for the Windows server"
  type        = string
  default     = "gp3"
}

variable "windows_cloud_init_file" {
  description = "Path to cloud-init file for the Windows server (optional)"
  type        = string
  default     = ""
}

# Common Variables
variable "key_name" {
  description = "Name of the key pair to use for SSH/RDP access"
  type        = string
  default     = ""
}

variable "instance_profile_name" {
  description = "Name of the instance profile to attach to the EC2 instances"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "public_key_path" {
  description = "Path to the public key file for the key pair"
  type        = string
  default = "./id_rsa.pub"
  
}