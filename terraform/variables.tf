variable "region" {
  type        = string
  description = "AWS region for deployment"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., prod, non-prod)"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "owner" {
  type        = string
  description = "Owner of the resources"
}