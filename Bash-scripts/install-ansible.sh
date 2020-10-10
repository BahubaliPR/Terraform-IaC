#!/bin/bash

function installAnsible() {

      sudo apt update && apt install software-properties-common
      sudo apt-add-repository --yes --update ppa:ansible/ansible
      sudo apt install -y ansible
}

installAnsible



