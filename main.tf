terraform {
  backend "s3" {
    bucket = "teste-terraform-storage"
    key    = "base/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {
  aws_account_id = var.aws_account_id 
  aws_region     = var.aws_region
}

provider "aws" {
  region              = local.aws_region
  allowed_account_ids = [local.aws_account_id]
}

module "test-vpc" {
  source             = "./vpc"
  vpc_cidr_block     = var.vpc_cidr_block
}

module "key_pair" {
  source             = "./key_pair"
  key_pair_name      = var.key_pair_name
}

module "instance-pub" {
  source                      = "./ec2"
  ec2_vpc_id                  = module.test-vpc.vpc_id
  ec2_subnet_id               = module.test-vpc.subnet_ids.public[0]
  aws_security_group          = module.test-vpc.secgp_management_id
  associate_public_ip_address = true
  key_pair_name               = var.key_pair_name
}

module "instance-pvt" {
  source                      = "./ec2"
  ec2_vpc_id                  = module.test-vpc.vpc_id
  ec2_subnet_id               = module.test-vpc.subnet_ids.private[0]
  aws_security_group          = module.test-vpc.secgp_management_id
  associate_public_ip_address = false
  key_pair_name               = var.key_pair_name
}