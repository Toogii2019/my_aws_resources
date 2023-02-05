# Variables


variable "environment" {
  description = "deployment environment"
}

variable "instance_type" {
  description = "instance type"
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

variable "public_key_location" {}

variable "private_key_location" {}