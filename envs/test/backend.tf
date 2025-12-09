terraform {
  backend "s3" {
    bucket         = "tf-state-yourbucket-test"
    key            = "test/terraform.tfstate"
    region         = var.region
    dynamodb_table = "tf-locks-test"
    encrypt        = true
  }
}