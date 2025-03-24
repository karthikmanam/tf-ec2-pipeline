terraform {
  backend "s3" {
    bucket         = "tf-state-karthik"
    key            = "non-prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}