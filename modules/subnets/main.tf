# Subnets

resource "aws_subnet" "generic-subnet" {

  count = length(var.environment_subnets)

  vpc_id = var.vpc_id
  cidr_block = var.environment_subnets[count.index].subnet_cidr_block
  availability_zone = var.environment_subnets[count.index].az
  tags = {
    Name: "${var.environment}-subnet-${count.index}"
    subnet_name = var.environment_subnets[count.index].name
  }
}

# Route tables

resource "aws_route_table" "generic_rt" {
  vpc_id = var.vpc_id

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
  vpc_id = var.vpc_id
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