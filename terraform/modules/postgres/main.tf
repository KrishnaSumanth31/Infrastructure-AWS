module "postgres" {
  source                        = "../../modules/postgres"
  region                        = var.region
  cluster_identifier            = var.cluster_identifier
  database_name                 = var.database_name
  master_username               = var.master_username
  master_password               = var.master_password
  security_group_id             = var.security_group_id
  db_subnet_group_name          = var.db_subnet_group_name
  auto_pause                    = var.auto_pause
  min_capacity                  = var.min_capacity  # Add this line
  max_capacity                  = var.max_capacity
  seconds_until_auto_pause      = var.seconds_until_auto_pause  # Add this line
  timeout_action                = var.timeout_action
  tags                          = var.tags
}
