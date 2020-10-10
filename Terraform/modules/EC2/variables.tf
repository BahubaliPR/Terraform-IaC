# EC2 instance related variables
variable "ami_id" {
   type = string
}

variable "ec2_count" {
   type = string
   default = 1
}

variable "keypair_name" {
   type = string
   default = "Integration_Lab_Key"
}

variable "associate_public_ip" {}

variable "instance_types" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "instance_tag" {
  type = list(string)
}

variable "securityGroup_id" {
  type = list
}

# EBS volume variables
variable  "delete_volume_on_termination" {
  type = string
}

variable "root_volume_size" {
  type = string
} 

variable "volume_types" {
  type = string
}

# Connection related variables
variable "connection_type" {
  type = string
}

variable "login_user" {
  type = string
}

# variable "host" {
#   type = string
# }

variable "private_keys" {
  type = string
}

# Source and Destination file path
variable "docker_source_path" {
  type = string
}

variable "docker_destination_path" {
  type = string
}

variable "ansible_source_path" {
  type = string
}

variable "ansible_destination_path" {
  type = string
}

variable "python_source_path" {
  type = string
}

variable "python_destination_path" {
  type = string
}

variable "kube_source_path_master" {
  type = string
}

variable "kube_destination_path_master" {
  type = string
}

variable "kube_source_path_worker" {
  type = string
}

variable "kube_destination_path_worker" {
  type = string
}

variable "javaJenkins_source_path" {
  type = string
}

variable "javaJenkins_destination_path" {
  type = string
}

