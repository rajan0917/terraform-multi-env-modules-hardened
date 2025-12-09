resource "aws_security_group" "this" {
  name = var.name
  description = var.description
  vpc_id = var.vpc_id
  tags = var.tags
}
resource "aws_security_group_rule" "ingress" {
  for_each = {
  idx = >
}
  type = "ingress"
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol
  cidr_blocks = lookup(each.value, "cidr_blocks", [])
  security_group_id = aws_security_group.this.id
}
resource "aws_security_group_rule" "egress" {
  for_each = {
  idx = >
}
  type = "egress"
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol
  cidr_blocks = lookup(each.value, "cidr_blocks", [])
  security_group_id = aws_security_group.this.id
}