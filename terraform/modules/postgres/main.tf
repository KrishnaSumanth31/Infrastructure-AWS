resource "aws_rds_cluster" "postgresql_serverless" {
  cluster_identifier        = var.cluster_id
  engine                    = "aurora-postgresql"
  engine_mode               = "provisioned"
  engine_version            = "15.2"
  database_name             = "testdatabaseinfra"
  master_username           = "mydb"
  master_password           = "testmedude"
  skip_final_snapshot       = true
  deletion_protection       = false

  tags = {
    Environment = var.environment
  }
}
