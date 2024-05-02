variable "region" {
  description = "The AWS region"
  type        = string
}

variable "bucket_name_artifact" {
  description = "The name of the artifact bucket"
  type        = string
}

variable "bucket_name_raw" {
  description = "The name of the raw bucket"
  type        = string
}

variable "environment" {
  description = "The environment name"
}

variable "cluster_id" {
  description = "The identifier for the DB cluster"
}

variable "username" {
  description = "The username for the secret"
  type        = string
}

variable "password" {
  description = "The password for the secret"
  type        = string
}

variable "port" {
  description = "The port for the DB"
  type        = string
}
