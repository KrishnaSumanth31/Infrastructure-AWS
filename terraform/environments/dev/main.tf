provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source = "../../modules/s3_bucket"

  bucket_name_first = var.bucket_name_first
  bucket_name_second = var.bucket_name_second

}  
