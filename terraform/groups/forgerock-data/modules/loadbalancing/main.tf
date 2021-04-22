resource "aws_lb" "main" {
  name                             = var.service_name
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = "true"
  internal                         = true
  subnets                          = var.subnet_ids
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.main.id
  port              = var.lb_port
  protocol          = "tcp"

  default_action {
    target_group_arn = aws_lb_target_group.main.id
    type             = "forward"
  }
}

resource "aws_lb_target_group" "main" {
  name        = var.service_name
  port        = var.lb_port
  protocol    = "tcp"
  vpc_id      = var.vpc_id
  target_type = "ip"
}
