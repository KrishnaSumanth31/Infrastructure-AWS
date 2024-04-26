#resource "aws_rds_cluster" "postgresql_serverless" {
#  cluster_identifier        = var.cluster_id
#  engine                    = "aurora-postgresql"
#  engine_mode               = "provisioned"
#  engine_version            = "15.2"
#  database_name             = "testdatabaseinfra"
#  master_username           = "mydb"
#  master_password           = "testmedude"
#  skip_final_snapshot       = true
#  deletion_protection       = false
#
#  tags = {
#    Environment = var.environment
#  }
#}


------------------------------------------------------------------------

resource "aws_rds_cluster_instance" "postgresql_serverless" {
  cluster_identifier             = var.cluster_id
  instance_identifier            = "${var.cluster_id}-instance"
  instance_class                 = "db.r5.large"  # Adjust instance class as per your requirements
  engine                         = "aurora-postgresql"
  engine_version                 = "15.2"  # Adjust engine version as per your requirements
  publicly_accessible            = false
  auto_minor_version_upgrade     = false
  apply_immediately              = true  # Apply changes immediately

  # Serverless V2 configuration
  db_subnet_group_name           = "rdsgroup"
  db_parameter_group_name        = "aurora-postgresql-parameters"

  # Specify existing VPC and subnets
  vpc_security_group_ids         = "sg-005e6c9357838f2e7"
  subnet_ids                     = "subnet-0ed4bf4f84fd76a0f"
  
  tags                           = { Environment = var.environment }
}


