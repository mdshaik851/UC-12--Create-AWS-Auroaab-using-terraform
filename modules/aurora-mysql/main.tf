# modules/aurora_rds/main.tf
data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = var.secret_arn
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-mysql"
  master_username         = local.db_creds.username
  master_password         = local.db_creds.password
  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name    = var.db_subnet_group_name
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = var.instance_count
  identifier         = "${var.cluster_identifier}-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.aurora.engine
}