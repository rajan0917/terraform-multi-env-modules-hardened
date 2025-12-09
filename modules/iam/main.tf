resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = var.assume_services
    }
  }
}

resource "aws_iam_policy" "scoped" {
  name   = "${var.name}-scoped"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ],
        Resource = [
          var.example_s3_bucket_arn,
          "${var.example_s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_scoped" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.scoped.arn
}
resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = toset(var.attach_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}


