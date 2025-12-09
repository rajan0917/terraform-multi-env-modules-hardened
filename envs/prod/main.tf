module "vpc" {
  source          = "../../modules/vpc"
  name            = "prod-vpc"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
  tags            = var.tags
}
module "s3" {
  source                     = "../../modules/s3"
  bucket_name                = "prod-app-bucket"
  versioning                 = true
  access_log_bucket          = ""
  enforce_tls_and_encryption = true
  tags                       = var.tags
}
module "route53" {
  source     = "../../modules/route53"
  zone_name  = "prod.example.com"
  www_record = false
  tags       = var.tags
}
module "notifications" {
  source = "../../modules/notifications"
  name   = "prod-alerts"
  email  = ""
  tags   = var.tags
}
module "rds" {
  source        = "../../modules/rds"
  identifier    = "prod-db"
  username      = "dbadmin"
  password      = "CHANGE_ME"
  subnet_ids    = []
  alarm_actions = [module.notifications.sns_topic_arn]
  tags          = var.tags
}
module "eks" {
  source            = "../../modules/eks"
  cluster_name      = "prod-eks"
  subnet_ids        = []
  create_node_group = true
  tags              = var.tags
}
module "alb" {
  source             = "../../modules/alb"
  name               = "prod-alb"
  subnets            = []
  vpc_id             = module.vpc.vpc_id
  enable_access_logs = true
  access_log_bucket  = ""
  alarm_actions      = [module.notifications.sns_topic_arn]
  tags               = var.tags
}
module "iam" {
  source                = "../../modules/iam"
  name                  = "prod-role"
  example_s3_bucket_arn = "arn:aws:s3:::prod-app-bucket"
  tags                  = var.tags
}
module "apigateway" {
  source      = "../../modules/apigateway"
  name        = "prod-api"
  description = "API for prod"
  tags        = var.tags
}
module "waf" {
  source    = "../../modules/waf"
  name      = "prod-waf"
  block_ips = []
  tags      = var.tags
}
module "nlb" {
  source  = "../../modules/nlb"
  name    = "prod-nlb"
  subnets = []
  vpc_id  = module.vpc.vpc_id
  tags    = var.tags
}