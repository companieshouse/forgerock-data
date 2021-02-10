variable "region" {
  type        = string
  description = "AWS region for deployment"
  default     = "eu-west-2"
}

variable "application_name" {
  type        = string
  description = "Application name. Used for naming AWS resources"
  default     = "forgerock-mongodb-connector"
}

variable "container_image_version" {
  type        = string
  description = "Version of the docker image to deploy"
  default     = "latest"
}
