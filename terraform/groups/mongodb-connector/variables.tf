variable "region" {
  type        = string
  description = "AWS region for deployment"
}

variable "environment" {
  type        = string
  description = "The environment name to be used when creating AWS resources"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC to be used for AWS resources"
}

variable "service_name" {
  type        = string
  description = "The service name to be used when creating AWS resources"
  default     = "forgerock-data"
}

variable "ecr_url" {
  type = string
}

variable "container_image_version" {
  type        = string
  description = "Version of the docker image to deploy"
  default     = "latest"
}

variable "task_cpu" {
  type        = number
  description = "The cpu unit limit for the ECS task"
}
variable "task_memory" {
  type        = number
  description = "The memory limit for the ECS task"
}

variable "rcs_client_secret" {
  type        = string
  description = "Client secret for the FIDC RSCClient application"
  sensitive = true
}

variable "fidc_url" {
  type = string
}

variable "rcs_server_key" {
  type        = string
  description = "Server key used by the remote connector server"
  sensitive = true
}

variable "connector_name_primary" {
  type        = string
  description = "FIDC remote connector name for primary connector"
}

variable "connector_name_secondary" {
  type        = string
  description = "FIDC remote connector name for secondary connector"
}

variable "directory_service_password" {
  type = string
  description = "Directory Service password used for backup instance"
  sensitive = true
}
