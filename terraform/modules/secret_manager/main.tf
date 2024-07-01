provider "aws" {
  region = "ap-south-1"  # Set your desired AWS region
}

resource "aws_secretsmanager_secret" "postgres_db_secrets_demos" {
  name = "postgres_db_secrets_dev_demos"
  description = var.description
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "postgres_db_secrets_demos_version" {
  secret_id     = aws_secretsmanager_secret.postgres_db_secrets_demos.id
  secret_string = jsonencode({
    username = var.username,
    password = var.password,
    port     = var.port
  })
}
