
#  VPC related variables
variable "cidr_block_vpc" {
    type = string
}

variable "instance_tenancy_vpc" {
    type = string
    default = "default"
}

variable "vpc_tags" {
    type = string
}

variable "main_vpc_id" {}

# Subnet related variables
variable "cidr_block_public_subnet" {
    type = string
}

variable "availability_zones" {     
    type = string
    default = "ap-south-1a"
}

# Route table and routes
variable "public_ipv4_route_cidr" {
    type = string
}

# Internet Gateway and NAT gateway
variable "internet_gateway_tag" {
    type = string
}

variable "public_route_table_tag" {
    type = string
}

# data "aws_availability_zones" "available_zones" {}
variable "public_subnet_tag" {
    type = string
}
