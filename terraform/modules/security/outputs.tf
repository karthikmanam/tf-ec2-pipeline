output "linux_security_group_id" {
  description = "ID of the Linux server security group"
  value       = aws_security_group.linux_server.id
}

output "windows_security_group_id" {
  description = "ID of the Windows server security group"
  value       = aws_security_group.windows_server.id
}

output "instance_profile_id" {
  description = "ID of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.id
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "iam_role_name" {
  description = "Name of the IAM role for EC2 instances"
  value       = aws_iam_role.ec2_role.name
}
