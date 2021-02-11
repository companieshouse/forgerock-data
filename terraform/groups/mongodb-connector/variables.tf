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
  default     = "forgerock-mongodb-connector"
}

variable "ecr-url" {
  type = string
}

variable "container_image_version" {
  type        = string
  description = "Version of the docker image to deploy"
  default     = "latest"
}
