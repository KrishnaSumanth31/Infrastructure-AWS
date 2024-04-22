provider "aws" {
  region = var.region
}

module "postgres_cluster" {
  source                = "../../modules/postgres"
  region                = var.region
  cluster_identifier    = var.cluster_identifier
  database_name         = var.database_name
  master_username       = var.master_username
  master_password       = var.master_password
  security_group_id     = var.security_group_id
  db_subnet_group_name  = var.db_subnet_group_name
  auto_pause            = var.auto_pause
  min_capacity          = var.min_capacity
  max_capacity          = var.max_capacity
  seconds_until_auto_pause = var.seconds_until_auto_pause
  timeout_action        = var.timeout_action
  tags                  = var.tags
}

module "aws_rds_cluster_instance" "cluster_instance" {
  source                = "../../modules/postgres"
  count                  = var.instance_count
  cluster_identifier     = module.postgres_cluster.cluster_identifier
  instance_class         = var.instance_class
  identifier             = "${module.postgres_cluster.cluster_identifier}-instance-${count.index + 1}"
}


