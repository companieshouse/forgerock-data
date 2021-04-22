resource "aws_security_group" "lb" {
  name        = "${var.service_name}-lb"
  description = "${var.service_name} loadbalancer"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 389
    to_port         = 389
    security_groups = [var.ecs_task_security_group_id]
  }
}
resource "aws_lb" "main" {
  name                             = var.service_name
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = "true"
  internal                         = true
  subnets                          = var.subnet_ids
  security_groups                  = [aws_security_group.lb.id]
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.main.id
  port              = var.lb_port
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.main.id
    type             = "forward"
  }
}

resource "aws_lb_target_group" "main" {
  name        = var.service_name
  port        = var.lb_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}
