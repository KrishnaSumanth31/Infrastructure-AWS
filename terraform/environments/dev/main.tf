provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source = "./terraform/modules/s3_bucket"

  bucket_name = var.bucket_name

}  
