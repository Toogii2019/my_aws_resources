

provider "aws" {
  # Configuration options
  region="us-west-2"
}

# Variables

variable "environment" {
  description = "deployment environment"
}

variable "environment_subnets" {
  description = "cidr blocks and name tags for subnets"
  type = list(object({
    subnet_cidr_block = string
    name = string
    az = string
    type = string
    public = bool
  }))
}

variable "environment_vpcs" {
  description = "cidr blocks and name tags for vpcs"
  type = object({
    vpc_cidr_block = string
    name = string
  })
}

variable "ips" {
  description = "public ip address"
}

# VPC Resources

resource "aws_vpc" "generic_vpc" {

  cidr_block = var.environment_vpcs.vpc_cidr_block
  tags = {
    Name: var.environment
    vpc_name: var.environment_vpcs.name
  }
}

# Route tables

resource "aws_route_table" "generic_rt" {
  vpc_id = aws_vpc.generic_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.generic_igw.id
  }
  tags = {
    Name: var.environment
  }
}

# Internet gateways

resource "aws_internet_gateway" "generic_igw" {
  vpc_id = aws_vpc.generic_vpc.id
  tags = {
    Name: var.environment
  }
}

# Route table associations

resource "aws_route_table_association" "generic_association" {
  count = length(var.environment_subnets)
  route_table_id = aws_route_table.generic_rt.id
  subnet_id = aws_subnet.generic-subnet[count.index].id

}

# Subnets

resource "aws_subnet" "generic-subnet" {

  count = length(var.environment_subnets)

  vpc_id = aws_vpc.generic_vpc.id
  cidr_block = var.environment_subnets[count.index].subnet_cidr_block
  availability_zone = var.environment_subnets[count.index].az
  tags = {
    Name: "${var.environment}-subnet-${count.index}"
    subnet_name = var.environment_subnets[count.index].name
  }
}

# Security Groups

resource "aws_security_group" "generic_security_group" {
  name = "generic_sg"
  vpc_id = aws_vpc.generic_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ips.sshipcidr]
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

data "aws_vpc" "existing-vpc" {
  default = true
}



