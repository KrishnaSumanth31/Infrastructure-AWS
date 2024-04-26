variable "region" {
  description = "AWS region"
}

variable "vpc_id" {
  description = "ID of the existing VPC"
}

variable "security_group_id" {
  description = "ID of the existing security group"
}

variable "cluster_identifier" {
  description = "Identifier for the RDS Aurora cluster"
}

variable "engine_version" {
  description = "Version of Aurora PostgreSQL engine"
  default     = "11.12" # adjust version as needed
}

variable "database_name" {
  description = "Name of the database"
}

variable "master_username" {
  description = "Username for the master user"
}

variable "master_password" {
  description = "Password for the master user"
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
}

variable "auto_pause" {
  description = "Whether to enable auto pause"
}

variable "max_capacity" {
  description = "Maximum capacity of the cluster"
}

variable "min_capacity" {
  description = "Minimum capacity of the cluster"
}

variable "seconds_until_auto_pause" {
  description = "Seconds until auto pause"
}

variable "tags" {
  description = "Tags to apply to AWS resources"
}
