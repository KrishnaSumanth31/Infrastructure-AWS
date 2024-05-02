provider "aws" {
  region = var.region
}

#module "s3_bucket" {
#  source         = "../../modules/s3_bucket"
#  bucket_name_artifact    = var.bucket_name_artifact
#  bucket_name_raw   = var.bucket_name_raw
#  region = var.region
#}


module "postgres" {
  source      = "../../modules/postgres"
  environment = var.environment
  cluster_id  = var.cluster_id
  region      = var.region
}

#module "athena" {
#  source      = "../../modules/athena"
#}

