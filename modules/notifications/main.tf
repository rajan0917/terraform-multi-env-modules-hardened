resource "aws_sns_topic" "alerts" {
  name = var.name
  tags = var.tags
}
resource "aws_sns_topic_subscription" "email" {
#  count     = var.email
  count     = var.email != "" ? 1 : 0
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.email
}
resource "aws_sns_topic_subscription" "sms" {
  for_each  = toset(var.sms_numbers)
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "sms"
  endpoint  = each.value
}
