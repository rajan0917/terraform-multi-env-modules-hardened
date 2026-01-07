terraform {
  backend "s3" {
    bucket         = "tf-state-mybucket-dev"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile   = false
    encrypt        = true
  }
}
