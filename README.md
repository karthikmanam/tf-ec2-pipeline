# AWS EC2 Infrastructure as Code

This repository contains Terraform code to deploy and manage a reusable AWS infrastructure with two EC2 servers (Windows and Linux) and associated networking components.

## Architecture

The infrastructure includes:

- VPC with CIDR range 10.1.0.0/16
- Public and private subnets across two availability zones
- Internet Gateway and NAT Gateway for outbound connectivity
- Two EC2 instances:
  - Linux server (Amazon Linux 2023)
  - Windows server (Windows Server 2022)
- Security groups for each instance
- Cloud-init configuration for initial server setup
- Support for static IP addresses

## Directory Structure

```
terraform/
├── environments/
│   ├── non-prod/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── security/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── cloud-init/
    ├── linux-init.yaml
    └── windows-init.ps1
```

## Prerequisites

- AWS Account with appropriate permissions
- Terraform 1.0.0 or later
- AWS CLI configured with appropriate credentials
- S3 bucket for Terraform state (referenced in backend configuration)
- DynamoDB table for state locking (referenced in backend configuration)

## Usage

### Local Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/ATIC-Yugandhar/tf-ec2-pipeline.git
   cd tf-ec2-pipeline
   ```

2. Navigate to the desired environment:
   ```bash
   cd terraform/environments/non-prod
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the deployment plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

### Deployment via GitHub Actions

This repository includes GitHub Actions workflows to automatically deploy the infrastructure.

To use the workflow:

1. Set up the following secrets in your GitHub repository:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key

2. Run the workflow manually from the Actions tab, or push to the main branch to trigger an automatic deployment.

3. The workflow allows you to select:
   - Environment (prod or non-prod)
   - Action (plan, apply, or destroy)

## Key Features

- **Environment Separation**: Different configurations for production and non-production environments
- **Reusable Modules**: All resources are organized into reusable modules
- **Cloud-Init Support**: Both Windows and Linux instances can be customized with cloud-init scripts
- **Static IP Support**: Options to configure static private IPs and/or Elastic IPs
- **Security**: Security groups limit access to only necessary ports

## Customization

### Modifying Server Configurations

To customize the EC2 instances, edit the `terraform.tfvars` file in the appropriate environment directory.

### Adding Cloud-Init Customizations

To customize the initialization scripts for the EC2 instances, modify the files in the `cloud-init` directory.
