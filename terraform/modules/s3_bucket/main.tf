resource "aws_s3_bucket" "bucket" {

  bucket = var.bucket_name_first
  acl = "private"
}

resource "aws_s3_bucket" "bucket-sample" {

  bucket = var.bucket_name_second
  acl = "private"
}
