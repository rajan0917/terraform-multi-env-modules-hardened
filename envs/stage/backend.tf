terraform {
  backend "s3" {
    bucket         = "tf-state-yourbucket-stage"
    key            = "stage/terraform.tfstate"
    region         = var.region
    dynamodb_table = "tf-locks-stage"
    encrypt        = true
  }
}