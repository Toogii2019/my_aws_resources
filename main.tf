

provider "aws" {
  # Configuration options
  region="us-west-2"
}

variable "environment" {
  description = "deployment environment"
}

variable "environment_subnets" {
  description = "cidr blocks and name tags for subnets"
  type = list(object({
    subnet_cidr_block = string
    name = string
  }))
}

variable "environment_vpcs" {
  description = "cidr blocks and name tags for vpcs"
  type = list(object({
    vpc_cidr_block = string
    name = string
  }))
}

resource "aws_vpc" "generic_vpc" {

  cidr_block = var.environment_vpcs[0].vpc_cidr_block
  tags = {
    Name: var.environment
    vpc_name: var.environment_vpcs[0].name
  }
}

resource "aws_subnet" "generic-subnet" {

  count = length(var.environment_subnets)

  vpc_id = aws_vpc.generic_vpc.id
  cidr_block = var.environment_subnets[count.index].subnet_cidr_block
  tags = {
    Name: var.environment
    subnet_name = var.environment_subnets[count.index].name
  }
}

data "aws_vpc" "existing-vpc" {
  default = true
}



