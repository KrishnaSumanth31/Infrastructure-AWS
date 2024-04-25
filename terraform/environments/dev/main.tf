provider "aws" {
  region = var.region
}

module "artifact_bucket" {
  source     = "../../modules/s3_bucket"
  bucket_name     = var.bucket_name_artifact
  bucket_name     = var.bucket_name_raw  
}

