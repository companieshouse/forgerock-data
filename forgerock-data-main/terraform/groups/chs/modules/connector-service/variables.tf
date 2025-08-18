variable "region" {
  type = string
}
variable "service_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "ecs_cluster_id" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "ecs_task_security_group_id" {
  type = string
}

variable "container_image_version" {
  type = string
}

variable "ecr_url" {
  type = string
}

variable "task_cpu" {
  type = number
}

variable "task_memory" {
  type = number
}

variable "rcs_client_secret" {
  type = string
}

variable "fidc_url" {
  type = string
}

variable "rcs_server_key" {
  type = string
}

variable "connector_name" {
  type = string
}

variable "log_group_name" {
  type = string
}

variable "log_prefix" {
  type = string
}

variable "tags" {
  type = object({
    Environment    = string
    Service        = string
    ServiceSubType = string
    Team           = string
  })
}

variable "rcs_jvm_args" {
  type = string
  description = "Flags for RCS JVM"
}

variable "inactive_file_url" {
  type        = string
  description = "URL for the inactive file"
}
