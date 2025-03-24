# VPC and Networking
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  tags = {
    Name        = "${var.environment}-subnet"
    Environment = var.environment
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.environment}-rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Security Group
resource "aws_security_group" "main" {
  name        = "${var.environment}-sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Environment = var.environment
  }
}

# EC2 Instances - Windows
resource "aws_instance" "windows" {
  count         = length(var.windows_instances)
  ami           = var.windows_instances[count.index].ami
  instance_type = var.windows_instances[count.index].instance_type
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]
  
  # Static private IP, no public IP
  associate_public_ip_address = false
  private_ip = var.windows_instances[count.index].private_ip

  # Cloud-init support
  user_data = var.windows_instances[count.index].user_data

  tags = {
    Name        = "${var.environment}-windows-${count.index}"
    Environment = var.environment
  }
}

# EC2 Instances - Linux
resource "aws_instance" "linux" {
  count         = length(var.linux_instances)
  ami           = var.linux_instances[count.index].ami
  instance_type = var.linux_instances[count.index].instance_type
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]
  
  # Static private IP, no public IP
  associate_public_ip_address = false
  private_ip = var.linux_instances[count.index].private_ip

  # Cloud-init support
  user_data = var.linux_instances[count.index].user_data

  tags = {
    Name        = "${var.environment}-linux-${count.index}"
    Environment = var.environment
  }
}