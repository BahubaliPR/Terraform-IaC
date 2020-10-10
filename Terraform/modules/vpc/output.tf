
# Provides output values
output "vpc_id_output_value" {
    value = aws_vpc.main_vpc.id
}

output "public_subnet_id_output_value" {
    value = aws_subnet.public_subnet.id
}

output "vpc_cidr_ouput_value" {
   value = aws_vpc.main_vpc.cidr_block
}