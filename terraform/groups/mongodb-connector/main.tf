module "ecs" {
  source                  = "./modules/ecs"
  application_name        = var.application_name
  container_image_version = var.container_image_version
  vpc_id                  = "TODO"
  subnets                 = "TODO"
  ecr_url                 = "TODO"
}

