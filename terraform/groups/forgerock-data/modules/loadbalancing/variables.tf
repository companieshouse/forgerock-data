variable "service_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "lb_port" {
  type = number
}

variable "ecs_task_security_group_id" {
  type = string
}
