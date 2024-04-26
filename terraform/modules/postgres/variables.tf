variable "environment" {
  description = "The environment name"
}

variable "cluster_id" {
  description = "The identifier for the DB cluster"
}

variable "region" {
  description = "The AWS region"
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
