provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment   = "non-prod"
      Project       = var.project_name
      ManagedBy     = "terraform"
      Owner         = var.owner
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "tf-statefile-manam"
    key            = "non-prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}