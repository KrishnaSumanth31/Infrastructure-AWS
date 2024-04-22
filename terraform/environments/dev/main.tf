provider "aws" {
  region = var.region
}

module "postgres" {
  source = "../../modules/postgres"

  engine                       = "aurora-postgresql"
  engine_mode                  = "serverless"
  cluster_identifier           = var.cluster_identifier
  database_name                = var.database_name
  master_username              = var.master_username
  master_password              = var.master_password
  vpc_security_group_ids       = [var.security_group_id]
  db_subnet_group_name         = var.db_subnet_group_name
  scaling_configuration {
    auto_pause                 = var.auto_pause
    min_capacity               = var.min_capacity
    max_capacity               = var.max_capacity
    seconds_until_auto_pause   = var.seconds_until_auto_pause
    timeout_action             = var.timeout_action
  }
  tags = var.tags
  
}  

