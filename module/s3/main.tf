terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
  }
}

resource "aws_s3_bucket" "b" {

  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = var.bucket_name
    Environment = var.env
  }

  lifecycle_rule {
    id      = var.lifecycle_id
    enabled = var.set_lifecycle

    prefix = "/"

    tags = {
      rule      = var.lifecycle_id
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_source_ip" {
  count = var.enable_policy ? 1 : 0
  bucket = aws_s3_bucket.b.id
  depends_on = [
    aws_s3_bucket.b
  ] 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSpecificIP"
        Effect    = "Allow"
        Principal = "*"
       Action = [
         "s3:GetObject",
         "s3:PutObject"
       ]
        Resource = [
          aws_s3_bucket.b.arn,
          "${aws_s3_bucket.b.arn}/*",
        ]
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "172.25.0.0/22"
          }
        }
      },
    ]
  })
}