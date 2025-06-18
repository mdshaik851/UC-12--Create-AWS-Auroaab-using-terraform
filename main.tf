terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
 }

  }
  required_version = ">= 1.10.0"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  private_subnet_cidrs = var.private_subnets
  availability_zones = var.availability_zone
}



# main.tf
module "secrets" {
  source       = "./modules/secret-manager"
  secret_name  = "aurora-db-secret1"
  db_username  = var.db_username
  password_length = var.password_length
}

module "aurora" {
  source               = "./modules/aurora-mysql"
  secret_arn           = module.secrets.secret_arn
  cluster_identifier   = var.cluster_identifier
  security_group_ids   = [module.vpc.security_group_id]
  db_subnet_group_name = module.vpc.subnet_group_name
  instance_class       = var.instance_class
  instance_count       = var.instance_count
}
