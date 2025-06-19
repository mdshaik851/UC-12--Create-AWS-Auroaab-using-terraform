# UC-12--Create-AWS-Auroaab-using-terraform
UC-12- Create AWS Auroaab using terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ./modules/aurora-mysql | n/a |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | ./modules/secret-manager | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `list(string)` | <pre>[<br>  "us-west-1a",<br>  "us-west-1b"<br>]</pre> | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | n/a | `string` | `"usecase-aurora"` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | n/a | `string` | `"admin"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | n/a | `string` | `"db.t3.medium"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | n/a | `number` | `2` | no |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | n/a | `number` | `16` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.0.3.0/24",<br>  "10.0.4.0/24"<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-west-1"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | Name of the secret containing database credentials |
<!-- END_TF_DOCS -->