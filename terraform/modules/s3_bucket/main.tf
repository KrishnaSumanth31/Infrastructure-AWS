resource "aws_s3_bucket" "bucket" {

  bucket = var.bucket_name_first
  aws_s3_bucket_acl = "private"
}

resource "aws_s3_bucket" "bucket-sample" {

  bucket = var.bucket_name_second
  aws_s3_bucket_acl = "private"
}
