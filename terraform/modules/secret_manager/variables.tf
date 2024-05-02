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

variable "description" {
  description = "The description for secrets"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the secret"
  type        = map(string)
}
