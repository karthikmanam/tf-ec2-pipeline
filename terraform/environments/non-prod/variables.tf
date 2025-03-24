variable "windows_instances" {
  type = list(object({
    ami           = string
    instance_type = string
    private_ip    = string
    user_data     = string
  }))
  description = "List of Windows EC2 instance configurations"
}

variable "linux_instances" {
  type = list(object({
    ami           = string
    instance_type = string
    private_ip    = string
    user_data     = string
  }))
  description = "List of Linux EC2 instance configurations"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "List of ingress rules for the security group"
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "List of egress rules for the security group"
}