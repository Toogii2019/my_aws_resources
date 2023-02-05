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

variable "vpc_id" {

}