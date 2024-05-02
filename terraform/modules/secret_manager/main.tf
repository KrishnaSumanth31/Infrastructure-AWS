provider "aws" {
  region = "ap-south-1"  # Set your desired AWS region
}

resource "aws_secretsmanager_secret" "postgres_db_secrets" {
  name = "postgres_db_secrets"
  description = var.description
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "postgres_db_secrets_version" {
  secret_id     = aws_secretsmanager_secret.postgres_db_secrets.id
  secret_string = jsonencode({
    username = var.username,
    password = var.password,
    port     = var.port
  })
  description = var.description
  tags        = var.tags
}
