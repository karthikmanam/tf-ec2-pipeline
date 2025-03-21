variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "List of CIDR blocks allowed to SSH to Linux server"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Consider restricting this in production
}

variable "rdp_allowed_cidrs" {
  description = "List of CIDR blocks allowed to RDP to Windows server"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Consider restricting this in production
}

variable "winrm_allowed_cidrs" {
  description = "List of CIDR blocks allowed to use WinRM to Windows server"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Consider restricting this in production
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
