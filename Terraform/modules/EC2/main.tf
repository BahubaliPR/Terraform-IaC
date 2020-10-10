# Creating EC2 instance
resource "aws_instance" "ec2_instance_master" {
  count                       = var.ec2_count
  ami                         = var.ami_id
  instance_type               = var.instance_types[0]
  subnet_id                   = var.subnet_id
  key_name                    = var.keypair_name
  security_groups             = var.securityGroup_id
  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    delete_on_termination     = var.delete_volume_on_termination
    volume_size               = var.root_volume_size
    volume_type               = var.volume_types
  }

  tags = {
    Name = var.instance_tag[0]
  }

  connection {
    type                       = var.connection_type
    user                       = var.login_user
    host                       = self.public_ip
    private_key                = var.private_keys
  }

  provisioner "file" {
    source        = var.docker_source_path
    destination   = var.docker_destination_path
}

  provisioner "file" {
    source        = var.ansible_source_path
    destination   = var.ansible_destination_path
}

  provisioner "file" {
    source        = var.python_source_path
    destination   = var.python_destination_path
}

  provisioner "file" {
    source        = var.kube_source_path_master
    destination   = var.kube_destination_path_master
}


provisioner "remote-exec" {
  inline = ["sudo bash /tmp/install-python.sh",
        "sleep 10s",
        "sudo bash /tmp/install-ansible.sh",
        "sleep 5s",
        "sudo bash /tmp/install-docker.sh",
        "sleep 5s",
        "sudo bash /tmp/install-kube-master.sh",
        "sleep 5s",
        "ip -4 addr show eth0 | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}' > ./IP_Addresses.txt"
        ]
}
}

# Creating EC2 instance
resource "aws_instance" "ec2_instance_worker" {
  count                       = var.ec2_count
  ami                         = var.ami_id
  instance_type               = var.instance_types[1]
  subnet_id                   = var.subnet_id
  key_name                    = var.keypair_name
  security_groups             = var.securityGroup_id
  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    delete_on_termination     = var.delete_volume_on_termination
    volume_size               = var.root_volume_size
    volume_type               = var.volume_types
  }

  tags = {
    Name = var.instance_tag[1]
  }

  connection {
    type                       = var.connection_type
    user                       = var.login_user
    host                       = self.public_ip
    private_key                = var.private_keys
  }

  provisioner "file" {
    source        = var.docker_source_path
    destination   = var.docker_destination_path
}

  provisioner "file" {
    source        = var.python_source_path
    destination   = var.python_destination_path
}

  provisioner "file" {
    source        = var.kube_source_path_worker
    destination   = var.kube_destination_path_worker
}

provisioner "remote-exec" {
  inline = ["sudo bash /tmp/install-python.sh",
        "sleep 10s",
        "sudo bash /tmp/install-docker.sh",
        "sleep 5s",
        "sudo bash /tmp/install-kube-worker.sh",
        "sleep 5s",
        "sudo apt-get update && sudo apt-get install -y apache2",
        "sleep 5s",
        "sudo chmod 657 /var/www/html",
        "sleep 5s",
        "ip -4 addr show eth0 | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}' > ./IP_Addresses.txt"
        ]
}
}

# Creating EC2 instance
resource "aws_instance" "ec2_instance_Jenkins" {
  count                       = var.ec2_count
  ami                         = var.ami_id
  instance_type               = var.instance_types[2]
  subnet_id                   = var.subnet_id
  key_name                    = var.keypair_name
  security_groups             = var.securityGroup_id
  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    delete_on_termination     = var.delete_volume_on_termination
    volume_size               = var.root_volume_size
    volume_type               = var.volume_types
  }

  tags = {
    Name = var.instance_tag[2]
  }

  connection {
    type                       = var.connection_type
    user                       = var.login_user
    host                       = self.public_ip
    private_key                = var.private_keys
  }

  
provisioner "file" {
    source             = var.javaJenkins_source_path
    destination        = var.javaJenkins_destination_path  
}

provisioner "remote-exec" {
  inline = ["sudo bash /tmp/Install-JAVA-Jenkins.sh",
        "ip -4 addr show eth0 | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}' > ./IP_Addresses.txt"
        ]
}
}
