# Creating a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block            = var.cidr_block_vpc
  instance_tenancy      = var.instance_tenancy_vpc

  tags = {
     Name = var.vpc_tags
  }
}

# Creating public subnet
resource "aws_subnet" "public_subnet" {
    vpc_id                = var.main_vpc_id
    cidr_block            = var.cidr_block_public_subnet
    availability_zone     = var.availability_zones
    
  tags = {
        Name = var.public_subnet_tag
  }
}

# Creating an internet gateway
resource "aws_internet_gateway" "interget_gateways" {
     vpc_id = var.main_vpc_id

     tags = {
       Name = var.internet_gateway_tag
     }
}

# Creating an route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  # Defining routes inside route table
  route {
    cidr_block = var.public_ipv4_route_cidr
    gateway_id = aws_internet_gateway.interget_gateways.id
  }

# Tags
  tags = {
    Name = var.public_route_table_tag
  }
}

# Associating subnets to route table
resource "aws_route_table_association" "route_table_associate" {
    subnet_id         = aws_subnet.public_subnet.id
    route_table_id    = aws_route_table.public_route_table.id
}

