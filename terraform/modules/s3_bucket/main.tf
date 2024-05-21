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
}

data "aws_iam_policy_document" "https_only_policy" {
  statement {
    actions   = ["s3:*"]
    effect    = "Deny"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.artifact_bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.artifact_bucket.bucket}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

data "aws_iam_policy_document" "allow_other_account_policy" {
  statement {
    actions   = ["s3:*"]
    effect    = "Allow"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.artifact_bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.artifact_bucket.bucket}/*",
      "arn:aws:s3:::${aws_s3_bucket.raw_bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.raw_bucket.bucket}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::123456789012:root"] # Replace with the AWS account ID you want to grant access to
    }
  }
}

data "aws_iam_policy_document" "combined_policy" {
  statement {
    actions   = ["s3:*"]
    effect    = "Deny"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.raw_bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.raw_bucket.bucket}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    actions   = ["s3:*"]
    effect    = "Allow"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.raw_bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.raw_bucket.bucket}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::123456789012:root"] # Replace with the AWS account ID you want to grant access to
    }
  }
}

resource "aws_s3_bucket_policy" "artifact_bucket_policy_https" {
  bucket = aws_s3_bucket.artifact_bucket.id
  policy = data.aws_iam_policy_document.https_only_policy.json
}


resource "aws_s3_bucket_policy" "raw_bucket_policy" {
  bucket = aws_s3_bucket.raw_bucket.id
  policy = data.aws_iam_policy_document.combined_policy.json
}
