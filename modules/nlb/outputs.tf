output "nlb_arn" { value = aws_lb.nlb.arn }
output "nlb_tg_arn" { value = aws_lb_target_group.tg.arn }