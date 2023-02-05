

data "aws_vpc" "existing-vpc" {
  default = true
}

data "aws_ami" "latest_al" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "generic_server" {
  #  ami = data.aws_ami.latest_al.id
  ami = "ami-0ceecbb0f30a902a6"
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = var.subnet_id
  security_groups = [var.security_group_id]
  user_data = file("entry-script.sh")
}