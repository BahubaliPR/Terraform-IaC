# Security group specific variables
variable "sg_name" {
    type = string
}

variable "sg_vpc_id" {
    type = string
}

# Specifies inbound rules
variable "ingress_from_port" {
    type = string
}

variable "ingress_to_port" {
    type = string
}

variable "ingress_protocol" {
    type = string
}

variable "ingress_vpc_cidr" {
    type = list
}

# specifies outbound rules
variable "egress_from_port" {
    type = string
}

variable "egress_to_port" {
    type = string
}

variable "egress_protocol" {
    type = string
}

variable "egress_vpc_cidr" {
    type = list
}

variable "sg_tags" {
    type = string
}