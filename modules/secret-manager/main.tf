# Generate a random password for the database
resource "random_password" "db_password" {
  length  = var.password_length
  special = true
  upper   = true
  lower   = true
  numeric = true
  override_special = "!#$%^&*()-_=+[]{}|:;,.<>?" # Allowed special characters
}


# modules/secrets_manager/main.tf
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = var.secret_name
  description = "Aurora DB credentials"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
  })
}