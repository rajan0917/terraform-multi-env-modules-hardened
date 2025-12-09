resource "aws_kms_key" "this" {
  description             = "KMS key for S3 ${var.bucket_name}"
  enable_key_rotation     = true
  deletion_window_in_days = 30
  tags                    = var.tags
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.bucket_name}-kms"
  target_key_id = aws_kms_key.this.id
}

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  acl           = var.acl
  force_destroy = var.force_destroy
  tags          = var.tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.this.arn
      }
    }
  }

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    id      = "default-lifecycle"
    enabled = var.lifecycle_enabled

    expiration {
      days = var.lifecycle_days
    }
  }

  logging {
    target_bucket = var.access_log_bucket != "" ? var.access_log_bucket : null
    target_prefix = var.access_log_prefix
  }
}

resource "aws_s3_bucket" "access_logs" {
  count  = var.create_access_log_bucket ? 1 : 0
  bucket = var.access_log_bucket_name != "" ? var.access_log_bucket_name : "${var.bucket_name}-access-logs"
  acl    = "log-delivery-write"
  tags   = var.tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.this.arn
      }
    }
  }

  versioning {
    enabled = false
  }
}

resource "aws_s3_bucket_policy" "secure" {
  count  = var.enforce_tls_and_encryption ? 1 : 0
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "DenyUnsecureTransport",
        Effect = "Deny",
        Principal = { AWS = "*" },
        Action    = "s3:*",
        Resource  = [aws_s3_bucket.this.arn, "${aws_s3_bucket.this.arn}/*"],
        Condition = {
          Bool = { "aws:SecureTransport" = "false" }
        }
      },
      {
        Sid    = "DenyUnEncryptedUploads",
        Effect = "Deny",
        Principal = { AWS = "*" },
        Action    = "s3:PutObject",
        Resource  = "${aws_s3_bucket.this.arn}/*",
        Condition = {
          StringNotEquals = { "s3:x-amz-server-side-encryption" = "aws:kms" }
        }
      }
    ]
  })
}

# Outputs — unique names and safe when optional resources are not created
output "primary_bucket_id" {
  description = "ID of the primary S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "primary_bucket_arn" {
  description = "ARN of the primary S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "primary_kms_key_arn" {
  description = "ARN of the KMS key used for this S3 bucket"
  value       = aws_kms_key.this.arn
}

output "access_log_bucket_id" {
  description = "ID of the access log bucket (empty string if not created)"
  value       = length(aws_s3_bucket.access_logs) > 0 ? aws_s3_bucket.access_logs[0].id : ""
}

output "access_log_bucket_arn" {
  description = "ARN of the access log bucket (empty string if not created)"
  value       = length(aws_s3_bucket.access_logs) > 0 ? aws_s3_bucket.access_logs[0].arn : ""
}

