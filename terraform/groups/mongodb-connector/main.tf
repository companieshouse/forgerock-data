###
# Data lookups
###
data "aws_vpc" "vpc" {
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnet_ids" "data_subnets" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = ["*-data-*"]
  }
}


module "ecs" {
  source                  = "./modules/ecs"
  service_name            = var.service_name
  vpc_id                  = data.aws_vpc.vpc.id
  subnet_ids              = data.aws_subnet_ids.data_subnets.ids
  ecr_url                 = var.ecr_url
  container_image_version = var.container_image_version
}

