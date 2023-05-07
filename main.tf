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