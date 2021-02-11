###
# Data lookups
###
data "aws_vpc" "vpc" {
  tags = {
    Name = var.vpc_name
  }
}


module "ecs" {
  source                  = "./modules/ecs"
  service_name            = var.service_name
  container_image_version = var.container_image_version
  vpc_id                  = data.aws_vpc.vpc.id
  # subnets =
  # ecr_url = 
}

