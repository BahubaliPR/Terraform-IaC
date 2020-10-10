resource "aws_security_group" "allow_tls_sg" {
    name        = var.sg_name
    vpc_id      = var.sg_vpc_id

  # Inboud Rules
  ingress {
      from_port   = var.ingress_from_port
      to_port     = var.ingress_to_port
      protocol    = var.ingress_protocol
      cidr_blocks = var.ingress_vpc_cidr
  }
  
  # Outbound Rule
  egress {
      from_port   = var.egress_from_port
      to_port     = var.egress_to_port
      protocol    = var.egress_protocol
      cidr_blocks = var.egress_vpc_cidr
  }

  tags = {
      Name = var.sg_tags
  }
}