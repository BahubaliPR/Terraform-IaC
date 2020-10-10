#!/bin/bash

function installPython() {

      sudo apt update && apt install software-properties-common
      sudo add-apt-repository -y ppa:deadsnakes/ppa
      sudo apt update && sudo apt install -y python3.8
}

installPython