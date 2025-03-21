data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

data "aws_ssm_parameter" "windows_server" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
}

# Linux Server
resource "aws_instance" "linux_server" {
  ami                    = data.aws_ssm_parameter.amazon_linux.value
  instance_type          = var.linux_instance_type
  key_name               = var.key_name
  subnet_id              = var.linux_subnet_id
  vpc_security_group_ids = [var.linux_security_group_id]
  iam_instance_profile   = var.instance_profile_name

  # Use static private IP if provided
  private_ip = var.linux_private_ip != "" ? var.linux_private_ip : null

  # Use cloud-init if file provided
  user_data = var.linux_cloud_init_file

  root_block_device {
    volume_size           = var.linux_root_volume_size
    volume_type           = var.linux_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-linux-server"
    }
  )

  lifecycle {
    ignore_changes = [ami]
  }
}

# Elastic IP for Linux Server (optional)
resource "aws_eip" "linux_eip" {
  count    = var.linux_assign_eip ? 1 : 0
  domain   = "vpc"
  instance = aws_instance.linux_server.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-linux-server-eip"
    }
  )
}

# Windows Server
resource "aws_instance" "windows_server" {
  ami                    = data.aws_ssm_parameter.windows_server.value
  instance_type          = var.windows_instance_type
  key_name               = var.key_name
  subnet_id              = var.windows_subnet_id
  vpc_security_group_ids = [var.windows_security_group_id]
  iam_instance_profile   = var.instance_profile_name

  # Use static private IP if provided
  private_ip = var.windows_private_ip != "" ? var.windows_private_ip : null

  # Use cloud-init (PowerShell script) if content provided
  user_data = var.windows_cloud_init_file
  root_block_device {
    volume_size           = var.windows_root_volume_size
    volume_type           = var.windows_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-windows-server"
    }
  )

  lifecycle {
    ignore_changes = [ami]
  }
}

# Elastic IP for Windows Server (optional)
resource "aws_eip" "windows_eip" {
  count    = var.windows_assign_eip ? 1 : 0
  domain   = "vpc"
  instance = aws_instance.windows_server.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-windows-server-eip"
    }
  )
}

#generate key
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

#create key pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh
  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-key-pair"
    }
  )
}