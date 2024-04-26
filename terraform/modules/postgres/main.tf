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


#------------------------------------------------------------------------
resource "aws_rds_cluster" "postgresql_serverless" {
  cluster_identifier             = var.cluster_id
  engine                         = "aurora-postgresql"
  engine_mode                    = "serverless"
  engine_version                 = "15.2"  # Adjust engine version as per your requirements
  database_name                  = "testdatabaseinfra"
  master_username                = "mydb"
  master_password                = "testmedude"

  # Serverless V2 configuration
  db_subnet_group_name           = "rdsgroup"

  # Specify existing VPC and subnets
  vpc_security_group_ids         = ["sg-005e6c9357838f2e7"]

  tags                           = { Environment = var.environment }
}

resource "aws_rds_cluster_instance" "postgresql_instance" {
  count                          = var.instance_count
  identifier                     = "${var.cluster_id}-instance-${count.index}"
  cluster_identifier             = aws_rds_cluster.postgresql_serverless.id
  instance_class                 = "db.r5.large"  # Adjust instance class as per your requirements
  engine                         = "aurora-postgresql"
  publicly_accessible            = false
  tags                           = { Environment = var.environment }
}





