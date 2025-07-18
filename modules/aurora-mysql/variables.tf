variable "secret_arn" {}
variable "cluster_identifier" {}
variable "security_group_ids" {
  type = list(string)
}
variable "db_subnet_group_name" {}
variable "instance_class" {}
variable "instance_count" {}
variable "secret_version_id" {
  description = "Version ID of the Secrets Manager secret"
  type        = string
}
