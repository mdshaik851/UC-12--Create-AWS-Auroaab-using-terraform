output "secret_name" {
  description = "Name of the secret containing database credentials"
  value       = module.secrets.secret_name
}
