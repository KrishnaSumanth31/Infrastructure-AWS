variable "region" {
  description = "AWS region"
}

variable "cluster_identifier" {
  description = "Aurora cluster identifier"
}

variable "database_name" {
  description = "Database name"
}

variable "master_username" {
  description = "Master username"
}

variable "master_password" {
  description = "Master password"
}

variable "security_group_id" {
  description = "ID of the security group for the cluster"
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
}

variable "auto_pause" {
  description = "Specifies whether the cluster is paused after a period of inactivity"
  type        = bool
}

variable "min_capacity" {
  description = "The minimum capacity for the Aurora serverless cluster"
}

variable "max_capacity" {
  description = "The maximum capacity for the Aurora serverless cluster"
}

variable "seconds_until_auto_pause" {
  description = "The amount of time before a paused Aurora serverless cluster is resumed"
}

variable "timeout_action" {
  description = "The action to take when the Aurora serverless cluster is paused"
}

variable "instance_count" {
  description = "Number of instances in the cluster"
  type        = number
  default     = 1
}

variable "instance_class" {
  description = "Instance class for the cluster instances"
  default     = "db.t3.small"
}

variable "tags" {
  description = "Tags for the cluster"
  type        = map(string)
}
