provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment   = local.environment
      Project       = var.project_name
      ManagedBy     = "terraform"
      Owner         = var.owner
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "tf-statefile-manam"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}