# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

# Linux Server Outputs
output "linux_instance_id" {
  description = "ID of the Linux server instance"
  value       = module.ec2.linux_instance_id
}

output "linux_private_ip" {
  description = "Private IP of the Linux server"
  value       = module.ec2.linux_private_ip
}

# output "linux_public_ip" {
#   description = "Public IP of the Linux server (if applicable)"
#   value       = module.ec2.linux_public_ip
# }

# output "linux_elastic_ip" {
#   description = "Elastic IP of the Linux server (if applicable)"
#   value       = module.ec2.linux_elastic_ip
# }

# Windows Server Outputs
# output "windows_instance_id" {
#   description = "ID of the Windows server instance"
#   value       = module.ec2.windows_instance_id
# }

# output "windows_private_ip" {
#   description = "Private IP of the Windows server"
#   value       = module.ec2.windows_private_ip
# }

# output "windows_public_ip" {
#   description = "Public IP of the Windows server (if applicable)"
#   value       = module.ec2.windows_public_ip
# }

# output "windows_elastic_ip" {
#   description = "Elastic IP of the Windows server (if applicable)"
#   value       = module.ec2.windows_elastic_ip
# }

# Security Group Outputs
output "linux_security_group_id" {
  description = "ID of the Linux server security group"
  value       = module.security.linux_security_group_id
}

output "windows_security_group_id" {
  description = "ID of the Windows server security group"
  value       = module.security.windows_security_group_id
}
