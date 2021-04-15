#!/usr/bin/env bash

# Script for installing docker in Ubuntu servers with AMD64 CPU arch.


# Variables:
myUser=$1       # First parameter is the users to be added to the Docker group.

# Update repos cache.
echo -e "\nUpdating repos cache."
sudo apt-get update

# Installing required packages.
echo -e "\nInstalling required packages."
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Adding gpg key.
echo -e "\nAdding gpg key."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Adding Docker repos.
echo -e "\nAdding official Docker repositories."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update repos cache.
echo -e "\nUpdating repos cache pt. 2."
sudo apt-get update

# Installing docker packages.
echo -e "\nInstalling docker packages."
sudo apt-get install -y docker-ce=5:18.09.5~3-0~ubuntu-bionic docker-ce-cli=5:18.09.5~3-0~ubuntu-bionic containerd.io

# Adding user to docker group.
echo -e "\nAdding user $myUser to docker group."
sudo usermod -aG docker $myUser
