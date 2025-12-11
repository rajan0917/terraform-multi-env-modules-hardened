# Terraform multi-env modules (complete, hardened)

Includes modules:
- route53, s3 (KMS-encrypted), apigateway, waf, iam, vpc, security_group, alb (access logs + alarm), nlb, eks (control-plane logs + KMS), rds (KMS + alarm)
- kms_policies templates and notifications (SNS) module

Usage:
- Edit envs/*/backend.tf to set your real S3 bucket & DynamoDB table for state locking.
- Populate sensitive variables (DB passwords, ARNs) via environment-specific `terraform.tfvars` or secrets.
- Run `terraform init` & `terraform validate` in an env folder, then `terraform plan` / `apply`.

###########################################################################################################################################################

# GitHub Actions setup that builds/deploys to multiple environments (dev/test/stage/prod).

1. Create one reusable workflow that does the heavy lifting (build, test, terraform plan/apply, deploy).

2. Create a tiny per-environment workflow (one file per env) that calls the reusable workflow with env-specific inputs. This keeps logic centralized and environment-specific settings (branch protection, approvals, secrets) separate and explicit.

3. Use GitHub Environments for approvals and environment-scoped secrets (e.g., AWS_ACCESS_KEY_ID_PROD vs AWS_ACCESS_KEY_ID_DEV), and branch protection for prod branch.

4. Use separate Terraform state/backends per environment (S3 key, workspace name) and CI credentials scoped per environment.

5. Optionally use workflow_dispatch to manually trigger or push to specific branches to automatically deploy.

###########################################################################################################################################################

1) Reusable workflow — .github/workflows/reusable-deploy.yml
2) Environment-specific workflows

   .github/workflows/deploy-dev.yml
   .github/workflows/deploy-test.yml
   .github/workflows/deploy-stage.yml
   .github/workflows/deploy-qa.yml
   .github/workflows/deploy-prod.yml
   
Each env workflow controls the trigger and the specific secrets used.

environment: production ties to GitHub Environment protections (required reviewers, approvals, secrets).

You get readable audit logs of who triggered prod deploys and when.

###########################################################################################################################################################

Additional best practices & important details

GitHub Environments: Create dev, staging, production environments in repository settings. Add required reviewers for production and attach environment-scoped secrets (so the workflow must pass approval to run). This is how you enforce manual approval for prod.

Secrets: Store credentials as environment-scoped secrets where possible. Use names like AWS_ACCESS_KEY_ID_PROD and AWS_SECRET_ACCESS_KEY_PROD. Avoid using a single global secret for all envs.

Least privilege: CI credentials should have just enough IAM permissions for the target environment (e.g., prod creds separate from dev creds).

State isolation: Use separate Terraform backend keys/buckets or distinct S3 keys and DynamoDB locks per environment to avoid state collisions.

Branch protection: Protect main/prod branch with required PR reviews, and require status checks that run the staging workflow or tests.

Immutable deployment artifacts: Build artifacts (docker images) in CI and tag by commit SHA. Push images to a registry (ECR/GCR) then deploy the tagged image — avoids races between build and deploy.

Testing: Make the reusable workflow run tests (unit, integration) before plan/apply.

Plan visibility: Save the terraform plan output and attach it to PRs or create a comment on the PR (for auditability).

Rollback strategy: Ensure deployments are reversible (old image tags still available, DB migrations have rollback path).

###########################################################################################################################################################
Quick checklist to implement this now

Add the three YAMLs above in .github/workflows/.

Create GitHub Environments (dev, staging, production) and add required secrets and reviewers.

Add secrets to repo: AWS_ACCESS_KEY_ID_DEV, AWS_SECRET_ACCESS_KEY_DEV, etc.

Ensure Terraform backend (S3 bucket + DynamoDB) exists and terraform_backend_key paths are used per env.

Protect production branch and require PRs + CI checks.

