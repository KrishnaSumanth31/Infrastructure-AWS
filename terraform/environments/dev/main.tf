provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source = "../../modules/s3_bucket"

  bucket = var.bucket_name_first
  
}  

module "s3_bucket_two" {
  source = "../../modules/s3_bucket"
  bucket = var.bucket_name_second
}
