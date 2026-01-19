resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "${var.name}-oac"
  description                       = "OAC for CloudFront ${var.name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  comment             = var.name
  default_root_object = var.default_root_object
  price_class         = var.price_class
  web_acl_id          = var.waf_acl_arn != "" ? var.waf_acl_arn : null

  origin {
    domain_name              = var.origin_domain_name
    origin_id                = var.origin_id
    origin_access_control_id = var.origin_type == "s3" ? aws_cloudfront_origin_access_control.this.id : null

    dynamic "custom_origin_config" {
      for_each = var.origin_type == "alb" ? [1] : []
      content {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_id

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn != "" ? var.acm_certificate_arn : null
    ssl_support_method             = var.acm_certificate_arn != "" ? "sni-only" : null
    minimum_protocol_version       = "TLSv1.2_2021"
    cloudfront_default_certificate = var.acm_certificate_arn == ""
  }

  aliases = var.aliases

  logging_config {
    bucket = var.logging_bucket != "" ? var.logging_bucket : null
    prefix = var.logging_prefix
    include_cookies = false
  }

  tags = var.tags
}
