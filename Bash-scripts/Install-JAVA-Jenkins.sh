#!/bin/bash

function installJava() {
    sudo apt update
    sudo apt install software-properties-common
    sudo apt update
    sudo apt install -y openjdk-8-jdk
    java -version > ./javaVersion.txt
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    export PATH=$PATH:$JAVA_HOME/bin
}

function installJenkins() {
    sudo apt-get update
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > \
        /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install -y jenkins
    sudo systemctl enable jenkins
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword > ./initialAdminPassword
}

function installJavaJenkins() {
    installJava
    installJenkins
}

installJavaJenkins