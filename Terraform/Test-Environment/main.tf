# Defined module for Creating VPC, Subnet, Internetgateway and rooute table.
module "test_vpc" {
    source                     = "../modules/vpc"
    cidr_block_vpc             = "172.103.0.0/26"
    #instance_tenancy_vpc      = "default"
    vpc_tags                   = "Practice_VPC"
    cidr_block_public_subnet   = "172.103.0.0/28"
    main_vpc_id                = module.test_vpc.vpc_id_output_value  # getting vpc_id from vpc output
    availability_zones         = "ap-south-1a" 
    public_subnet_tag          = "Practice_Public_Subnet"
    internet_gateway_tag       = "Practice_Internet_Gateway"
    public_route_table_tag     = "Practice_Public_Route_Table"
    public_ipv4_route_cidr     = "0.0.0.0/0"
 }

# Module to create a security group
module "test_sg" {
    source = "../modules/SecurityGroup"
    sg_name        = "test_securityGroup"
    sg_vpc_id      = module.test_vpc.vpc_id_output_value # getting vpc_id from vpc output

  # Inboud Rules
      ingress_from_port           = 0
      ingress_to_port             = 0
      ingress_protocol            = "-1"
      ingress_vpc_cidr            = ["0.0.0.0/0"]
  
  # Outbound Rules
      egress_from_port     = 0
      egress_to_port       = 0
      egress_protocol      = "-1"
      egress_vpc_cidr      = ["0.0.0.0/0"]
   
  # Tags
      sg_tags = "Practice_SecurityGroup"

}

# Creating EC2 instance under public subnet
module "test_public_ec2_instances_master" {
    source                 = "../modules/EC2"
    ec2_count              = 1
    ami_id                 = "ami-03f0fd1a2ba530e75"
    instance_types         = ["t2.micro","t2.micro","t2.micro"]
    associate_public_ip    = "true"
    subnet_id              = module.test_vpc.public_subnet_id_output_value
    keypair_name           = "cicd"
    instance_tag           = ["Master","Worker","Jenkins"]
    securityGroup_id       = [module.test_sg.securityGroup_id_output_value]

# EBS volume 
    delete_volume_on_termination  = "true"
    root_volume_size              = "18"
    volume_types                  = "gp2"  

#Login to remote server
    connection_type        = "ssh"
    login_user             = "ubuntu"
    #host                   = self.public_ip
    private_keys           = "${file("F:\\AWS EC2 Instance Key\\<PEM KEY>")}"  #-------------> Add PEM key

# Provisioner file

    python_source_path                         = "F:\\ELK-CICD-Pipeline\\Bash-scripts\\install-python.sh"
    python_destination_path                    = "/tmp/install-python.sh"

    ansible_source_path                        = "F:\\ELK-CICD-Pipeline\\Bash-scripts\\install-ansible.sh"
    ansible_destination_path                   = "/tmp/install-ansible.sh"

    docker_source_path                         = "F:\\ELK-CICD-Pipeline\\Bash-scripts\\install-docker.sh"
    docker_destination_path                    = "/tmp/install-docker.sh"

    kube_source_path_master                    = "F:\\ELK-CICD-Pipeline\\Bash-scripts\\install-kube-master.sh"
    kube_destination_path_master               = "/tmp/install-kube-master.sh"

    kube_source_path_worker                    = "F:\\ELK-CICD-Pipeline\\Bash-scripts\\install-kube-worker.sh"
    kube_destination_path_worker               = "/tmp/install-kube-worker.sh"
    
    javaJenkins_source_path                    = "F:\\ELK-CICD-Pipeline\\Bash-scripts\\Install-JAVA-Jenkins.sh"
    javaJenkins_destination_path               = "/tmp/Install-JAVA-Jenkins.sh"
    
}

