provider "aws" {
  region = var.region
}

module "aws_s3_bucket" "artifact-bucket" {
  source                = "../../modules/s3_bucket"
  bucket = var.bucket_name_artifact  
}

module "aws_s3_bucket" "raw-bucket" {
  source                = "../../modules/s3_bucket"
  bucket = var.bucket_name_raw  
}

