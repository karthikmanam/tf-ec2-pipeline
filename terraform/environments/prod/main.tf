module "ec2_nonprod" {
  source          = "../../modules/ec2"
  environment     = "non-prod"
  vpc_cidr        = "10.1.0.0/16"
  subnet_cidr     = "10.1.1.0/24"
  windows_instances = var.windows_instances
  linux_instances   = var.linux_instances
  ingress_rules     = var.ingress_rules
  egress_rules      = var.egress_rules
}