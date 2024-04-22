provider "aws" {
  region = var.region
}

module "postgres" {
  source = "../../modules/postgres"
  
  cluster_identifier             = var.cluster_identifier
  engine                         = "aurora-postgresql"
  engine_mode                    = "serverless"
  database_name                  = var.database_name
  master_username                = var.master_username
  master_password                = var.master_password
  vpc_security_group_ids         = [var.security_group_id]
  db_subnet_group_name           = var.db_subnet_group_name
  auto_pause                     = var.auto_pause
  min_capacity                   = var.min_capacity
  max_capacity                   = var.max_capacity
  seconds_until_auto_pause       = var.seconds_until_auto_pause
  timeout_action                 = var.timeout_action
  count                  = var.instance_count
  instance_class         = var.instance_class
  identifier             = "${var.cluster_identifier}-instance-${count.index + 1}"
  tags = var.tags
    
}  

