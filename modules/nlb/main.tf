resource "aws_lb" "nlb" {
  name = var.name
  load_balancer_type = "network"
  subnets = var.subnets
  tags = var.tags
}
resource "aws_lb_target_group" "tg" {
  name = "${var.name}-tg"
  port = var.target_port
  protocol = var.target_protocol
  target_type = var.target_type
  vpc_id = var.vpc_id

  # Optional health check (uncomment and configure if needed)
  # health_check {
  #   path     = var.health_path
  #   protocol = var.health_protocol
  #   matcher  = var.health_matcher
  # }

  tags = var.tags
}
