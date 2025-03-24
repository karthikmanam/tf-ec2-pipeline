module "ec2_prod" {
  source          = "../../modules/ec2"
  environment     = "prod"
  vpc_cidr        = var.vpc_cidr
  subnet_cidr     = var.subnet_cidr
  windows_instances = var.windows_instances
  linux_instances   = var.linux_instances
  ingress_rules     = var.ingress_rules
  egress_rules      = var.egress_rules
}