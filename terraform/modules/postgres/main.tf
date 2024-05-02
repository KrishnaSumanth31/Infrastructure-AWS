resource "random_password" "master_password" {
  length           = 20
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "database_credentials" {
  name = "database_credentials"

  # Generate a JSON string with the credentials
  secret_string = jsonencode({
    username = "tm_dev_admin",  # Define your master username here
    password = random_password.master_password.result
  })

  # Enable rotation with a rotation lambda
  rotation_lambda_config {
    rotation_rules {
      automatically_after_days = 30
    }
  }
}

resource "aws_rds_cluster" "postgresql_serverless" {
  cluster_identifier             = var.cluster_id
  engine                         = "aurora-postgresql"
  engine_mode                    = "provisioned"
  engine_version                 = "15.2"
  database_name                  = "testdatabaseinfra"
  master_username                = jsondecode(aws_secretsmanager_secret.database_credentials.secret_string)["username"]
  master_password                = jsondecode(aws_secretsmanager_secret.database_credentials.secret_string)["password"]
  db_subnet_group_name           = "default"
  vpc_security_group_ids         = ["sg-005e6c9357838f2e7"]
  deletion_protection            = false
  apply_immediately              = true
  enabled_cloudwatch_logs_exports = ["postgresql"]
  skip_final_snapshot            = true
  final_snapshot_identifier      = "${var.cluster_id}-final-snapshot"
  db_cluster_parameter_group_name = "default.aurora-postgresql15"
  iam_database_authentication_enabled = true
  storage_encrypted              = true
  kms_key_id                     = aws_kms_key.database_credentials_key.arn
  tags                           = { Environment = var.environment }
}

resource "aws_rds_cluster_instance" "postgresql_instance" {
  count                          = 1  
  identifier                     = "${var.cluster_id}-instance-${count.index}"
  cluster_identifier             = aws_rds_cluster.postgresql_serverless.id
  instance_class                 = "db.r5.large"
  engine                         = "aurora-postgresql"
  publicly_accessible            = false
  performance_insights_enabled   = true
  performance_insights_retention_period = 7
  db_parameter_group_name        = "default.aurora-postgresql15"
  tags                           = { Environment = var.environment }
}

output "rds_cluster_endpoint" {
  value = aws_rds_cluster.postgresql_serverless.endpoint
}




#------------------------------------------------------------------------
#resource "aws_secretsmanager_secret" "database_credentials" {
#  name = "database_credentials_devlop"
#  SecretString = jsonencode({
#    username = "mydevdb",
#    password = "Test@me"
#  })
#}

#resource "aws_secretsmanager_secret_version" "database_credentials_version" {
#  secret_id     = aws_secretsmanager_secret.database_credentials.id
#}

#resource "aws_rds_cluster" "postgresql_serverless" {
#  cluster_identifier             = var.cluster_id
#  engine                         = "aurora-postgresql"
#  engine_mode                    = "provisioned"
#  engine_version                 = "15.2"  # Adjust engine version as per your requirements
#  database_name                  = "testdatabaseinfra"
#  master_username                = aws_secretsmanager_secret.database_credentials.username
#  master_password                = aws_secretsmanager_secret.database_credentials.password
#  # Serverless V2 configuration
#  db_subnet_group_name           = "default"

  # Specify existing VPC and subnets
#  vpc_security_group_ids         = ["sg-005e6c9357838f2e7"]
#  deletion_protection            = false
#  apply_immediately              = true
#  enabled_cloudwatch_logs_exports = ["postgresql"]
#  skip_final_snapshot            = true  # Since deletion_protection is set to false, skipping final snapshot is recommended
#  final_snapshot_identifier      = "${var.cluster_id}-final-snapshot"
#  db_cluster_parameter_group_name = "default.aurora-postgresql15"
#  iam_database_authentication_enabled = true
#  storage_encrypted              = true
#  kms_key_id = aws_kms_key.database_credentials_key.arn  # Use the KMS key for encrypting the cluster
#  tags                           = { Environment = var.environment }
#}

#resource "aws_rds_cluster_instance" "postgresql_instance" {
#  count                          = 1  
#  identifier                     = "${var.cluster_id}-instance-${count.index}"
#  cluster_identifier             = aws_rds_cluster.postgresql_serverless.id
#  instance_class                 = "db.r5.large"  # Adjust instance class as per your requirements
#  engine                         = "aurora-postgresql"
#  publicly_accessible            = false
#  performance_insights_enabled   = true
#  performance_insights_retention_period = 7  # Adjust retention period as needed
#  db_parameter_group_name        = "default.aurora-postgresql15"
#  tags                           = { Environment = var.environment }
#}

#output "rds_cluster_endpoint" {
#  value = aws_rds_cluster.postgresql_serverless.endpoint
#}







