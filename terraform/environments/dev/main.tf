provider "aws" {
  region = var.region
}

module "aws_s3_bucket" "artifact-bucket" {
  source                = "../../modules/s3_bucket"
  
}


