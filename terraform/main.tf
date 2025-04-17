module "vpc" {
  source = "./modules/vpc"
  
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  
  tags = var.tags
}

module "alb" {
  source = "./modules/alb"
  
  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnet_ids
  
  tags = var.tags
}

module "ecs" {
  source = "./modules/ecs"
  
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  private_subnets   = module.vpc.private_subnet_ids
  container_port    = var.container_port
  container_image   = var.container_image
  container_cpu     = var.container_cpu
  container_memory  = var.container_memory
  desired_count     = var.desired_count
  alb_target_group_arn = module.alb.target_group_arn
  alb_security_group_id = module.alb.this_security_group_id
  
  tags = var.tags
}