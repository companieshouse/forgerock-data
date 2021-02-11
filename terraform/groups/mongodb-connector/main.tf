###
# Data sources
###
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["/${var.environment}/i"]
    regex  = true
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

