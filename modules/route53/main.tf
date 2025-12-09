resource "aws_route53_zone" "this" {
  name          = var.zone_name
  comment       = var.comment
  force_destroy = var.force_destroy
  tags          = var.tags
}
resource "aws_route53_record" "www" {
  count   = var.www_record ? 1 : 0
  zone_id = aws_route53_zone.this.zone_id
  name    = "www.${var.zone_name}"
  type    = "A"
  ttl     = var.www_ttl
  records = var.www_records
}