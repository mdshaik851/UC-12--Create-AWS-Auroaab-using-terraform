output "secret_arn" {
  value = aws_secretsmanager_secret.db_credentials.arn
}

output "secret_version_id" {
  value = aws_secretsmanager_secret_version.db_credentials_version.version_id
}
