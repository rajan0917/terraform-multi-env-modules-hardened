resource "aws_kms_key" "rds" {
  enable_key_rotation = true
  deletion_window_in_days = 30
  tags = var.tags
}
resource "aws_db_subnet_group" "this" {
  # The 'name' argument is used to set the name of the subnet group
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_parameter_group" "this" {
  # The 'name' argument is used to set the name of the parameter group
  name        = "${var.identifier}-pg"
  family      = var.parameter_family
  description = "Parameter group"
}
resource "aws_db_instance" "this" {

  identifier = var.identifier
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  username = var.username
  password = var.password
  db_subnet_group_name = aws_db_subnet_group.this.name
  parameter_group_name = aws_db_parameter_group.this.name
  multi_az = var.multi_az
  skip_final_snapshot = var.skip_final_snapshot
  backup_retention_period = var.backup_retention
  storage_encrypted = true
  kms_key_id = aws_kms_key.rds.arn
}
resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  alarm_name          = "${var.identifier}-HighCPU"
  namespace           = "AWS/RDS"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_alarm_threshold

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.id
  }

  alarm_actions = var.alarm_actions
}
