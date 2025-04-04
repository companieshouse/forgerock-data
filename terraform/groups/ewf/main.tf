###
# Data lookups
###
data "aws_vpc" "vpc" {
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnets" "data_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_id]
  }
  filter {
    name = "tag:Name"
    values = ["*-application-*"]
  }
}
###
# Modules
###
module "ecs" {
  source       = "./modules/ecs"
  service_name = var.service_name
  vpc_id       = data.aws_vpc.vpc.id
  tags         = local.common_tags
}

module "primary" {
  source                     = "./modules/connector-service"
  region                     = var.region
  service_name               = "rcs-primary"
  environment                = var.environment
  subnet_ids                 = data.aws_subnets.data_subnets.ids
  ecs_cluster_id             = module.ecs.cluster_id
  ecs_task_role_arn          = module.ecs.task_role_arn
  ecs_task_security_group_id = module.ecs.task_security_group_id
  rds_security_group_id      = var.rds_security_group_id
  container_image_version    = "rcs-${var.container_image_version}"
  ecr_url                    = var.ecr_url
  task_cpu                   = var.cpu_limit
  task_memory                = var.memory_limit
  rcs_client_secret          = var.rcs_client_secret
  fidc_url                   = var.fidc_url
  rcs_server_key             = var.rcs_server_key
  connector_name             = var.rcs_name_primary
  log_group_name             = "forgerock-monitoring"
  log_prefix                 = "rcs-primary"
  tags                       = local.common_tags
  rcs_jvm_args               = var.rcs_jvm_args
}

module "secondary" {
  source                     = "./modules/connector-service"
  region                     = var.region
  service_name               = "rcs-secondary"
  environment                = var.environment
  subnet_ids                 = data.aws_subnets.data_subnets.ids
  ecs_cluster_id             = module.ecs.cluster_id
  ecs_task_role_arn          = module.ecs.task_role_arn
  ecs_task_security_group_id = module.ecs.task_security_group_id
  rds_security_group_id      = var.rds_security_group_id
  container_image_version    = "rcs-${var.container_image_version}"
  ecr_url                    = var.ecr_url
  task_cpu                   = var.cpu_limit
  task_memory                = var.memory_limit
  rcs_client_secret          = var.rcs_client_secret
  fidc_url                   = var.fidc_url
  rcs_server_key             = var.rcs_server_key
  connector_name             = var.rcs_name_secondary
  log_group_name             = "forgerock-monitoring"
  log_prefix                 = "rcs-secondary"
  tags                       = local.common_tags
  rcs_jvm_args               = var.rcs_jvm_args
}
