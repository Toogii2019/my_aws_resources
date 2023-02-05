# Security Groups

resource "aws_security_group" "generic_security_group" {
  name = "generic_sg"
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ips.any]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [var.ips.any]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.ips.any]
  }

  tags = {
    Name: var.environment
  }
}