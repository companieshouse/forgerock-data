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
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*-applications-*"]
  }
}

data "vault_generic_secret" "secrets" {
  path = "applications/${var.environment}-${var.region}/chs/${var.service_name}"
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

module "chs_primary" {
  source                     = "./modules/connector-service"
  region                     = var.region
  service_name               = "rcs-primary"
  environment                = var.environment
  subnet_ids                 = data.aws_subnet_ids.data_subnets.ids
  ecs_cluster_id             = module.ecs.cluster_id
  ecs_task_role_arn          = module.ecs.task_role_arn
  ecs_task_security_group_id = module.ecs.task_security_group_id
  container_image_version    = "rcs-${var.container_image_version}"
  ecr_url                    = var.ecr_url
  task_cpu                   = var.connector_cpu
  task_memory                = var.connector_memory
  rcs_client_secret          = var.rcs_client_secret
  fidc_url                   = var.fidc_url
  rcs_server_key             = var.rcs_server_key
  connector_name             = var.rcs_name_primary
  log_group_name             = "forgerock-monitoring"
  log_prefix                 = "rcs-primary"
  tags                       = local.common_tags
  rcs_jvm_args               = var.rcs_jvm_args
  inactive_file_url          = local.inactive_file_url
}

module "chs_secondary" {
  source                     = "./modules/connector-service"
  region                     = var.region
  service_name               = "rcs-secondary"
  environment                = var.environment
  subnet_ids                 = data.aws_subnet_ids.data_subnets.ids
  ecs_cluster_id             = module.ecs.cluster_id
  ecs_task_role_arn          = module.ecs.task_role_arn
  ecs_task_security_group_id = module.ecs.task_security_group_id
  container_image_version    = "rcs-${var.container_image_version}"
  ecr_url                    = var.ecr_url
  task_cpu                   = var.connector_cpu
  task_memory                = var.connector_memory
  rcs_client_secret          = var.rcs_client_secret
  fidc_url                   = var.fidc_url
  rcs_server_key             = var.rcs_server_key
  connector_name             = var.rcs_name_secondary
  log_group_name             = "forgerock-monitoring"
  log_prefix                 = "rcs-secondary"
  tags                       = local.common_tags
  rcs_jvm_args               = var.rcs_jvm_args
  inactive_file_url          = local.inactive_file_url
}

module "directory_service_lb" {
  source       = "./modules/loadbalancing"
  service_name = "${var.service_name}-ds-backup"
  vpc_id       = data.aws_vpc.vpc.id
  subnet_ids   = data.aws_subnet_ids.data_subnets.ids
  lb_port      = 389
  tags         = local.common_tags
}

module "directory_service" {
  source                     = "./modules/ds-service"
  region                     = var.region
  service_name               = "directory-service-backup"
  vpc_id                     = data.aws_vpc.vpc.id
  vpc_cidr_block             = data.aws_vpc.vpc.cidr_block
  subnet_ids                 = data.aws_subnet_ids.data_subnets.ids
  ecs_cluster_id             = module.ecs.cluster_id
  ecs_task_role_arn          = module.ecs.task_role_arn
  ecs_task_security_group_id = module.ecs.task_security_group_id
  container_image_version    = "ds-${var.container_image_version}"
  ecr_url                    = var.ecr_url
  task_cpu                   = var.ds_backup_cpu
  task_memory                = var.ds_backup_memory
  ds_password                = var.directory_service_password
  log_group_name             = "forgerock-monitoring"
  log_prefix                 = "directory-service-backup"
  target_group_arn           = module.directory_service_lb.target_group_arn
  tags                       = local.common_tags
}

module "forgerock_export" {
  source                     = "./modules/connector-service"
  region                     = var.region
  service_name               = "forgerock-export"
  environment                = var.environment
  subnet_ids                 = data.aws_subnet_ids.data_subnets.ids
  ecs_cluster_id             = module.ecs.cluster_id
  ecs_task_role_arn          = module.ecs.task_role_arn
  ecs_task_security_group_id = module.ecs.task_security_group_id
  container_image_version    = "rcs-${var.container_image_version}"
  ecr_url                    = var.ecr_url
  task_cpu                   = var.connector_cpu
  task_memory                = var.connector_memory
  rcs_client_secret          = var.rcs_client_secret
  fidc_url                   = var.fidc_url
  rcs_server_key             = var.rcs_server_key
  connector_name             = "forgerock-export"
  log_group_name             = "forgerock-monitoring"
  log_prefix                 = "forgerock-export"
  tags                       = local.common_tags
  rcs_jvm_args               = var.rcs_jvm_args
  inactive_file_url          = local.inactive_file_url
}
