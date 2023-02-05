
 module "subnets" {
   source = "./modules/subnets"
   environment_subnets = var.environment_subnets
   vpc_id = aws_vpc.generic_vpc.id
   environment = var.environment
 }

 module "securitygroup" {
   source = "./modules/securitygroup"
   vpc_id = aws_vpc.generic_vpc.id
   ips = var.ips
   environment = var.environment
 }

 module "webservers" {
   source = "./modules/webservers"
   count = length(var.environment_subnets)
   vpc_id = aws_vpc.generic_vpc.id
   ips = var.ips
   subnet_id = module.subnets.subnets[count.index].id
   environment = var.environment
   public_key_location = var.public_key_location
   instance_type = var.instance_type
   security_group_id = module.securitygroup.security_group.id

 }

# VPC Resources

resource "aws_vpc" "generic_vpc" {
  cidr_block = var.environment_vpcs.vpc_cidr_block
  tags = {
    Name: var.environment
    vpc_name: var.environment_vpcs.name
  }
}

