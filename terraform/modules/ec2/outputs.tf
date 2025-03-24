output "windows_instance_ids" {
  value = aws_instance.windows[*].id
}

output "linux_instance_ids" {
  value = aws_instance.linux[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}