region                         = "us-west-2"
cluster_identifier             = "my-aurora-cluster"
database_name                  = "my_database"
master_username                = "admin"
master_password                = "password123"
security_group_id              = "sg-038868d72acc5b6b7"  # Replace with your security group ID
db_subnet_group_name           = "my-db-subnet-group"
auto_pause                     = true
min_capacity                   = 1
max_capacity                   = 16
seconds_until_auto_pause       = 300
timeout_action                 = "ForceApplyCapacityChange"
tags = {
  Environment = "dev"
  Name        = "my-aurora-cluster"
}
