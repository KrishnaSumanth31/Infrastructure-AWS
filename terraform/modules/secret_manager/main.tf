provider "aws" {
  region = "ap-south-1"  # Set your desired AWS region
}

resource "aws_secretsmanager_secret" "postgres_db_secrets_demo" {
  name = "postgres_db_secrets_dev_demo"
  description = var.description
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "postgres_db_secrets_demo_version" {
  secret_id     = aws_secretsmanager_secret.postgres_db_secrets_demo.id
  secret_string = <<EOF
  {
  "username": "${var.username}",
  "password": "${var.password}",
  "port": "${var.port}"
}
EOF
}
