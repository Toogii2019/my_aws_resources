environment_subnets = [{"subnet_cidr_block":"172.21.102.0/24", "name": "subnet1", "az": "us-west-2a", "type": "private", "public": "false"},
                       {"subnet_cidr_block":"172.21.103.0/24", "name": "subnet2", "az": "us-west-2b", "type": "private", "public": "false"},
                       {"subnet_cidr_block":"172.21.104.0/24", "name": "subnet3", "az": "us-west-2c", "type": "private", "public": "false"}
                      ]

environment_vpcs = {"vpc_cidr_block":"172.21.0.0/16", "name": "prod_vpc"}

ips = {"sshipcidr" :"205.251.233.53/32", "any": "0.0.0.0/0"}

instance_type = "t2.micro"

public_key_location = "~/.ssh/aws_id_rsa.pub"

environment = "production"