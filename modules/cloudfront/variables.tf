variable "name" {
  type        = string
  description = "CloudFront distribution name"
}

variable "origin_domain_name" {
  type        = string
  description = "Origin domain name (S3 bucket or ALB DNS)"
}

variable "origin_id" {
  type        = string
  description = "Origin identifier"
}

variable "origin_type" {
  type        = string
  description = "Origin type: s3 or alb"
  validation {
    condition     = contains(["s3", "alb"], var.origin_type)
    error_message = "origin_type must be either s3 or alb"
  }
}

variable "default_root_object" {
  type    = string
  default = "index.html"
}

variable "price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "default_ttl" {
  type    = number
  default = 3600
}

variable "max_ttl" {
  type    = number
  default = 86400
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "acm_certificate_arn" {
  type    = string
  default = ""
}

variable "waf_acl_arn" {
  type    = string
  default = ""
}

variable "logging_bucket" {
  type    = string
  default = ""
}

variable "logging_prefix" {
  type    = string
  default = "cloudfront/"
}

variable "tags" {
  type    = map(string)
  default = {}
}
