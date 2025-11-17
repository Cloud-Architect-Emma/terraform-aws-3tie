module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  region   = var.region
}

module "ec2" {
  source    = "./modules/ec2"
  subnet_id = module.vpc.public_subnet_id
  count     = 2  # For scaling
}

module "alb" {
  source     = "./modules/alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
}

module "rds" {
  source      = "./modules/rds"
  db_password = var.db_password
  sg_id       = module.vpc.db_sg_id
}

# Multi-region: Use providers for each region
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

module "vpc_west" {
  providers = { aws = aws.west }
  source    = "./modules/vpc"
  # ... similar config
}
