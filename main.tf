provider "aws" {
  region = var.region
  default_tags {
    tags = {
      project = var.nombre
    }
  }
  access_key = "AKIAV336K2Z2ZAUUWJGH"
  secret_key = "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"

}

## Deploy Network Infrastructure for an environment
module "dev_infrastructure" {
  source      = "./my_modules/infrastructure"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  nombre      = var.nombre
  az_numbers  = 2

}

module "alb" {
  source     = "./my_modules/balancers"
  nombre     = var.nombre
  my_vpc_id  = module.dev_infrastructure.vpc_id
  my_subnets = module.dev_infrastructure.public_subnet_ids

}

module "eks" {
  source     = "./my_modules/eks"
  nombre     = var.nombre
  my_vpc_id  = module.dev_infrastructure.vpc_id
  my_subnets = module.dev_infrastructure.public_subnet_ids
  alb_sg_id  = module.alb.alb_sg_id
}

module "dynamodb" {
  source     = "./my_modules/databases"
  table_name = "orders"
  hash_key   = "orderId"
  tags = {
    Name = "Orders Table"
  }
}

