
resource "aws_vpc" "custom" {
 cidr_block = var.vpc_cidr
 enable_dns_support = true
 enable_dns_hostnames = true
 tags = {
    Name = "demo-vpc-uc-12"
  }
}

#Creation Internet Gateway
resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.custom.id
  tags = {
    Name = "demo-vpc-uc12-igw"
  }
}

#Create EIP
resource "aws_eip" "eip" {
  tags = {
    Name = "demo-vpc-uc12-eip"
  }
}



resource "aws_subnet" "public" {
 count = length(var.public_subnet_cidrs)
 vpc_id = aws_vpc.custom.id
 cidr_block = var.public_subnet_cidrs[count.index]
 availability_zone = var.availability_zones[count.index]
}

resource "aws_subnet" "private" {
 count = length(var.private_subnet_cidrs)
 vpc_id = aws_vpc.custom.id
 cidr_block = var.private_subnet_cidrs[count.index]
 availability_zone = var.availability_zones[count.index]
}

#Create Nat gateway
resource "aws_nat_gateway" "demo-natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "demo-vpc-uc2-nat-gw"
  }
}

#Assigning Internet to Internet Gateway in Routes
resource "aws_route_table" "public_routes" {
vpc_id = aws_vpc.custom.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Assigning Internet to Nat Gateway in Routes
resource "aws_route_table" "private_routes" {
vpc_id = aws_vpc.custom.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.demo-natgw.id
  }
}

#Adding Public subnets in Subnet Association
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_routes.id
}

#Adding Private subnets in Subnet Association
resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_routes.id
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

 ingress {
 from_port = 3306
 to_port = 3306
 protocol = "tcp"
 security_groups = [aws_security_group.aurora_testing_sg.id]
 }

 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "aurora_testing_sg" {
 name = "aurora_testing_sg"
 description = "Security group for Aurora RDS"
 vpc_id = aws_vpc.custom.id

 ingress {
 from_port = 22
 to_port = 22
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

