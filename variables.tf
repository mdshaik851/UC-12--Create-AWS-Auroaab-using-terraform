variable "region" {
  type = string
  default = "us-west-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zone" {
  type = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}

variable "private_subnets" {
  type = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}


variable "db_username" {
  default = "admin"
}

variable "cluster_identifier" {
  default = "usecase-aurora"
}

variable "instance_class" {
  default = "db.t3.medium"
}
variable "instance_count" {
  default = 2
}

variable "password_length" {
  default = 16
}

variable "instance_type" {
  
}

variable "ami_id" {
  
}
