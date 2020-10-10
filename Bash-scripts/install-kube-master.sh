#!/bin/bash
function installKubeMaster() {

    sudo apt-get update && sudo apt-get install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
          
    cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list 
    deb https://apt.kubernetes.io/ kubernetes-xenial main 
EOF

    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo touch ./get_IPAddress.sh ./join-command.txt
    sudo chmod +x ./get_IPAddress.sh ./join-command.txt
    sudo echo "ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'" > ./get_IPAddress.sh
    var=$(sudo bash ./get_IPAddress.sh)
    sudo kubeadm init  --apiserver-advertise-address=$var  --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=all > ./join-command.txt

# These commands will be shown on terminal after running above command line:
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config    

# Run Below command to add nodes in to network:
    kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml

    sudo kubectl get nodes

}

installKubeMaster