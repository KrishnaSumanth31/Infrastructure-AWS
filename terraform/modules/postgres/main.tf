resource "aws_rds_cluster" "postgresql_serverless" {
  cluster_identifier        = var.cluster_id
  engine                    = "aurora-postgresql"
  engine_mode               = "serverless"
  engine_version            = "15.2"
  database_name             = "test-database"
  master_username           = "admin"
  master_password           = "password"
  skip_final_snapshot       = true
  deletion_protection       = false
  
  scaling_configuration {
    auto_pause               = true
    max_capacity             = 8
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
  
  tags = {
    Environment = var.environment
  }
}
