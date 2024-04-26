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
  region                    = var.region
  scaling_configuration {
    auto_pause = var.auto_pause
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
    seconds_until_auto_pause = var.seconds_until_auto_pause
  }
  tags = {
    Environment = var.environment
  }
}
