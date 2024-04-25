resource "aws_s3_bucket" "artifact-bucket" {
  bucket = var.bucket_name_artifact
  acl = "private"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "raw-bucket" {

  bucket = var.bucket_name_raw
  acl = "private"

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
 object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
}
