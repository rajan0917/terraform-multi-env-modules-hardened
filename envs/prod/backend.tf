terraform {
  backend "s3" {
    bucket         = "tf-state-yourbucket-prod"
    key            = "prod/terraform.tfstate"
    region         = var.region
    dynamodb_table = "tf-locks-prod"
    encrypt        = true
  }
}