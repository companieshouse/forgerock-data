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
    values = ["*-applications-*"]
  }
}

###
# Modules
###
module "ecs" {
  source       = "./modules/ecs"
  service_name = var.service_name
  vpc_id       = data.aws_vpc.vpc.id
}

module "ecs-task-primary" {
  source                     = "./modules/ecs-task"
  depends_on                 = [module.monitoring]
  region                     = var.region
  service_name               = "${var.service_name}-primary"
  subnet_ids                 = data.aws_subnet_ids.data_subnets.ids
  ecs_cluster_id             = module.ecs.cluster_id
  ecs_task_role_arn          = module.ecs.task_role_arn
  ecs_task_security_group_id = module.ecs.task_security_group_id
  container_image_version    = var.container_image_version
  ecr_url                    = var.ecr_url
  task_cpu                   = var.task_cpu
  task_memory                = var.task_memory
  rcs_client_secret          = var.rcs_client_secret
  fidc_url                   = var.fidc_url
  rcs_server_key             = var.rcs_server_key
  connector_name             = var.connector_name_primary
  log_group_name             = "forgerock-monitoring"
  log_prefix                 = "mongodb-connector-primary"
}

module "ecs-task-secondary" {
  source                     = "./modules/ecs-task"
  depends_on                 = [module.monitoring]
  region                     = var.region
  service_name               = "${var.service_name}-secondary"
  subnet_ids                 = data.aws_subnet_ids.data_subnets.ids
  ecs_cluster_id             = module.ecs.cluster_id
  ecs_task_role_arn          = module.ecs.task_role_arn
  ecs_task_security_group_id = module.ecs.task_security_group_id
  container_image_version    = var.container_image_version
  ecr_url                    = var.ecr_url
  task_cpu                   = var.task_cpu
  task_memory                = var.task_memory
  rcs_client_secret          = var.rcs_client_secret
  fidc_url                   = var.fidc_url
  rcs_server_key             = var.rcs_server_key
  connector_name             = var.connector_name_secondary
  log_group_name             = "forgerock-monitoring"
  log_prefix                 = "mongodb-connector-secondary"
}

