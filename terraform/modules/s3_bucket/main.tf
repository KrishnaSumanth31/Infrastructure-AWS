provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket = var.bucket_name_artifact
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "raw_bucket" {
  bucket = var.bucket_name_raw
  acl    = "private"

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    transition {
      days          = 150
      storage_class = "DEEP_ARCHIVE"
    }

    expiration {
      days = 365
    }
  }

  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
}
