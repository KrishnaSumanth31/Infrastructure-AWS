provider "aws" {
  region = "us-west-2"  # Set your desired AWS region
}

resource "aws_secretsmanager_secret" "example_secret" {
  name = "example_secret"
}

resource "aws_secretsmanager_secret_version" "example_secret_version" {
  secret_id     = aws_secretsmanager_secret.example_secret.id
  secret_string = jsonencode({
    username = var.username,
    password = var.password
  })
}
