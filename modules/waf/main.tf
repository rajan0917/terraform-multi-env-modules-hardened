resource "aws_wafv2_web_acl" "this" {
  name  = var.name
  scope = var.scope
  default_action { 
	allow {} 
}

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.name
    sampled_requests_enabled   = true
  }

  dynamic "rule" {
    for_each = var.block_ips != null && length(var.block_ips) > 0 ? [1] : []
    content {
      name     = "block-ips"
      priority = 0
      action { 
	block {} 
	}
      statement {
        ip_set_reference_statement { arn = aws_wafv2_ip_set.blocklist.arn }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "block-ips"
        sampled_requests_enabled   = true
      }
    }
  }
}

resource "aws_wafv2_ip_set" "blocklist" {
  count = var.block_ips != null && length(var.block_ips) > 0 ? 1 : 0
  name = "${var.name}-blocked"
  scope = var.scope
  ip_address_version = "IPV4"
  addresses = var.block_ips
}
