resource "aws_s3_bucket" "alb_logs" {
  count = var.create_access_log_bucket ? 1 : 0

  bucket = var.access_log_bucket_name != "" ? var.access_log_bucket_name : "${var.name}-alb-logs"

  acl = "private"

  tags = var.tags
}

resource "aws_lb" "app" {
  name               = var.name
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups

  access_logs {
    enabled = var.enable_access_logs
    bucket  = var.create_access_log_bucket ? aws_s3_bucket.alb_logs[0].id : var.access_log_bucket
    prefix  = var.access_log_prefix
  }

  tags = var.tags
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.name}-tg"
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpc_id

  health_check {
    path     = var.health_path
    protocol = var.health_protocol
    matcher  = var.health_matcher
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "alb_unhealthy" {
  alarm_name          = "${var.name}-UnhealthyHosts"
  namespace           = "AWS/ApplicationELB"
  metric_name         = "UnHealthyHostCount"
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 2
  threshold           = var.unhealthy_threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"

  dimensions = {
    TargetGroup  = aws_lb_target_group.tg.arn_suffix
    LoadBalancer = aws_lb.app.arn_suffix
  }

  alarm_actions = var.alarm_actions
}

