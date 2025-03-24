region        = "us-east-1"
environment   = "non-prod"
project_name  = "my-project"
owner         = "karthik"

windows_instances = [
  {
    ami           = "ami-windows-latest"  # Replace with actual AMI ID
    instance_type = "t2.micro"
    private_ip    = "10.1.1.10"
    user_data     = <<EOF
<powershell>
Write-Output "Initializing Prod Windows Server"
</powershell>
EOF
  }
]

linux_instances = [
  {
    ami           = "ami-ubuntu-latest"  # Replace with actual AMI ID
    instance_type = "t2.micro"
    private_ip    = "10.1.1.11"
    user_data     = <<EOF
#!/bin/bash
echo "Initializing Prod Linux Server" > /tmp/init.log
EOF
  }
]

vpc_cidr    = "10.1.0.0/16"
subnet_cidr = "10.1.1.0/24"

ingress_rules = [
  {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.1.0.0/16"]
  }
]