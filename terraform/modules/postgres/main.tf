provider "aws" {
  region = var.region
}

# Define the existing VPC and its subnets
data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

data "aws_subnet_ids" "existing_subnets" {
  vpc_id = data.aws_vpc.existing_vpc.id
}

# Define the existing security group
data "aws_security_group" "existing_security_group" {
  id = var.security_group_id
}

# Create an RDS cluster parameter group
resource "aws_rds_cluster_parameter_group" "aurora_pg" {
  name        = "aurora-postgresql-parameters"
  family      = "aurora-postgresql11"
  description = "Parameter group for Aurora PostgreSQL"
  
  parameter {
    name  = "shared_buffers"
    value = "1024MB"
  }

  # Add other parameters as needed
}

# Create the RDS Aurora PostgreSQL cluster
resource "aws_rds_cluster" "aurora_pg_cluster" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-postgresql"
  engine_mode             = "serverless"
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  skip_final_snapshot     = true
  vpc_security_group_ids  = [data.aws_security_group.existing_security_group.id]
  db_subnet_group_name    = var.db_subnet_group_name
  cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_pg.id
  
  scaling_configuration {
    auto_pause = var.auto_pause
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
    seconds_until_auto_pause = var.seconds_until_auto_pause
  }

  lifecycle {
    ignore_changes = [scaling_configuration[0].auto_pause]
  }

  tags = var.tags
}


---------------------------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = "your-region"
}

# Define the existing VPC and its subnets
data "aws_vpc" "existing_vpc" {
  id = "your-existing-vpc-id"
}

data "aws_subnet_ids" "existing_subnets" {
  vpc_id = data.aws_vpc.existing_vpc.id
}

# Define the existing security group
data "aws_security_group" "existing_security_group" {
  id = "your-existing-security-group-id"
}

# Create an RDS cluster parameter group
resource "aws_rds_cluster_parameter_group" "aurora_pg" {
  name        = "aurora-postgresql-parameters"
  family      = "aurora-postgresql11"
  description = "Parameter group for Aurora PostgreSQL"
  
  parameter {
    name  = "shared_buffers"
    value = "1024MB"
  }

  # Add other parameters as needed
}

# Create the RDS Aurora PostgreSQL cluster
resource "aws_rds_cluster" "aurora_pg_cluster" {
  cluster_identifier      = "your-cluster-identifier"
  engine                  = "aurora-postgresql"
  engine_mode             = "serverless"
  engine_version          = "11.12" # adjust version as needed
  database_name           = "your_database_name"
  master_username         = "your_master_username"
  master_password         = "your_master_password"
  skip_final_snapshot     = true
  vpc_security_group_ids  = [data.aws_security_group.existing_security_group.id]
  db_subnet_group_name    = "your-db-subnet-group" # If using RDS in VPC
  cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_pg.id
  
  scaling_configuration {
    auto_pause = true
    max_capacity = 16
    min_capacity = 1
    seconds_until_auto_pause = 300
  }

  lifecycle {
    ignore_changes = [scaling_configuration[0].auto_pause]
  }

  tags = {
    Name = "your-cluster-name"
  }
}
