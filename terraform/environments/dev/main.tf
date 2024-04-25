provider "aws" {
  region = var.region
}

module "artifact_bucket" {
  source     = "../../modules/s3_bucket"
  bucket     = var.bucket_name_artifact  
}

module "raw_bucket" {
  source     = "../../modules/s3_bucket"
  bucket     = var.bucket_name_raw  
}


