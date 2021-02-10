variable "application_name" {
  type = string
}

variable "container_image_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(any)
}

variable "ecr_url" {
  type = string
}

