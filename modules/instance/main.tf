resource "aws_instance" "Aurora-testing" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.security_groups_id_ec2]
  associate_public_ip_address = true

  tags = {
    Name = "fAurora_testing"
  }
}