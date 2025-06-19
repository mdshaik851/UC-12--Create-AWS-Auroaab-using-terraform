
resource "aws_vpc" "custom" {
 cidr_block = var.vpc_cidr
 enable_dns_support = true
 enable_dns_hostnames = true
}

resource "aws_subnet" "private" {
 count = length(var.private_subnet_cidrs)
 vpc_id = aws_vpc.custom.id
 cidr_block = var.private_subnet_cidrs[count.index]
 availability_zone = var.availability_zones[count.index]
}


resource "aws_security_group" "aurora_sg" {
 name = "aurora-sg"
 description = "Security group for Aurora RDS"
 vpc_id = aws_vpc.custom.id

 ingress {
 from_port = 3306
 to_port = 3306
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "aurora-subnet-group"
  }
}

