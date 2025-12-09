terraform {
  backend "s3" {
    bucket         = "tf-state-yourbucket-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-2"
    use_lockfile = false
    encrypt        = true
  }
}
