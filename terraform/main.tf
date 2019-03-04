# VPC
module "vpc" {
  source  = "modules/vpc"
  project = "${ var.project }"
  aws     = "${ var.aws }"
  env     = "${ var.env }"
  eip     = "${ var.eip }"
  vpc     = "${ var.vpc }"
}

# Security Group
module "security_group" {
  source     = "modules/security_group"
  project    = "${ var.project }"
  aws        = "${ var.aws }"
  env        = "${ var.env }"
  vpc        = "${ var.vpc }"
  office_ips = "${ var.office_ips }"
  output_vpc = "${ module.vpc.vpc }"
}

# IAM
module "iam" {
  source     = "modules/iam"
  project    = "${ var.project }"
  aws        = "${ var.aws }"
  env        = "${ var.env }"
}

# EC2
module "ec2" {
  source     = "modules/ec2"
  project    = "${ var.project }"
  aws        = "${ var.aws }"
  env        = "${ var.env }"
  eip        = "${ var.eip }"
  vpc        = "${ var.vpc }"
  ec2        = "${ var.ec2 }"
  output_vpc = "${ module.vpc.vpc }"
  output_sg  = "${ module.security_group.sg }"
  output_iam = "${ module.iam.iam }"
}

# ALB
module "alb" {
  source     = "modules/alb"
  project    = "${ var.project }"
  aws        = "${ var.aws }"
  env        = "${ var.env }"
  output_vpc = "${ module.vpc.vpc }"
  output_sg  = "${ module.security_group.sg }"
}

# ECS
module "ecs" {
  source     = "modules/ecs"
  project    = "${ var.project }"
  aws        = "${ var.aws }"
  env        = "${ var.env }"
  output_vpc = "${ module.vpc.vpc }"
  output_sg  = "${ module.security_group.sg }"
  output_iam = "${ module.iam.iam }"
  output_alb = "${ module.alb.alb }" 
}

