# Terraform multi-env modules (complete, hardened)

Includes modules:
- route53, s3 (KMS-encrypted), apigateway, waf, iam, vpc, security_group, alb (access logs + alarm), nlb, eks (control-plane logs + KMS), rds (KMS + alarm)
- kms_policies templates and notifications (SNS) module

Usage:
- Edit envs/*/backend.tf to set your real S3 bucket & DynamoDB table for state locking.
- Populate sensitive variables (DB passwords, ARNs) via environment-specific `terraform.tfvars` or secrets.
- Run `terraform init` & `terraform validate` in an env folder, then `terraform plan` / `apply`.
