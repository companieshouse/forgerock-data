variable "region" {
  type = string
}

variable "service_name" {
  type = string
}

variable "container_image_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
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