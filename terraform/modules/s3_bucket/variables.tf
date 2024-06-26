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
