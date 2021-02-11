resource "aws_cloudwatch_log_group" "connector" {
  name = var.service_name
}
