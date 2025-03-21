# Linux Server Security Group
resource "aws_security_group" "linux_server" {
  name        = "${var.environment}-linux-server-sg"
  description = "Security group for Linux server"
  vpc_id      = var.vpc_id

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-linux-server-sg"
    }
  )
}

# Windows Server Security Group
resource "aws_security_group" "windows_server" {
  name        = "${var.environment}-windows-server-sg"
  description = "Security group for Windows server"
  vpc_id      = var.vpc_id

  # RDP access
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.rdp_allowed_cidrs
  }

  # WinRM access (if needed)
  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = var.winrm_allowed_cidrs
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-windows-server-sg"
    }
  )
}

# IAM role for EC2 instances
resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# IAM instance profile for EC2 instances
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# Attach policy for SSM (enables AWS Systems Manager management)
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
