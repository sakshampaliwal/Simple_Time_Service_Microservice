aws_region          = "ap-south-1"
project_name        = "simple-time-service"
vpc_cidr            = "10.0.0.0/16"
availability_zones  = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
container_port      = 5000
container_cpu       = 256
container_memory    = 512
desired_count       = 2
container_image      = "public.ecr.aws/x9i9z9i1/simple-time-service:latest"

tags = {
  Project     = "SimpleTimeService"
  Environment = "dev"
  Terraform   = "true"
  Owner       = "DevOps"
}