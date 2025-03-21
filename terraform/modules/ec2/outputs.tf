# Linux Server Outputs
output "linux_instance_id" {
  description = "ID of the Linux server instance"
  value       = aws_instance.linux_server.id
}

output "linux_private_ip" {
  description = "Private IP of the Linux server"
  value       = aws_instance.linux_server.private_ip
}

output "linux_public_ip" {
  description = "Public IP of the Linux server (if applicable)"
  value       = aws_instance.linux_server.public_ip
}

output "linux_elastic_ip" {
  description = "Elastic IP of the Linux server (if applicable)"
  value       = var.linux_assign_eip ? aws_eip.linux_eip[0].public_ip : null
}

# Windows Server Outputs
output "windows_instance_id" {
  description = "ID of the Windows server instance"
  value       = aws_instance.windows_server.id
}

output "windows_private_ip" {
  description = "Private IP of the Windows server"
  value       = aws_instance.windows_server.private_ip
}

output "windows_public_ip" {
  description = "Public IP of the Windows server (if applicable)"
  value       = aws_instance.windows_server.public_ip
}

output "windows_elastic_ip" {
  description = "Elastic IP of the Windows server (if applicable)"
  value       = var.windows_assign_eip ? aws_eip.windows_eip[0].public_ip : null
}
