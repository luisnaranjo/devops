#! /usr/bin/bash

# Script:       vagrant-fedora-setup.sh
# Author:       Luis Antonio Naranjo Mora.
# Description:  Bash script for initial Vagrant-VirtualBox setup.
# Targets:      Linux Red Hat-based systems.
# Return codes:
#   - 0: Executiong successful.
#   - 1: User running script is not root.



### VARIABLES:
# General:
PKG_MGR='dnf'   # Specify the package manager to be used.

# Virtualbox:
VB_REPO_URL='https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo' # URL containing the repo info.
VB_REPO_FILE='/etc/yum.repos.d/virtualbox.repo'                                     # File repo name in local system.
VB_PACKAGE_NAME='VirtualBox-6.1'                                                    # Package name for installation.
VB_DEP_PACKAGE_NAME='kernel-devel'                                                  # Dependency package needed for VirtualBox.

# Vagrant:
VGRNT_PACKAGE_NAME='vagrant'    # Package name for installation.


### FUNCTIONS:
# Function for message formatting for each installation steps.
function msgPrint
{
  echo -e "\n###################################"
  echo $1
}

# Function that verify if script is run by root.
# This script needs to be run with elevated privileges since it performs package installations & repository file configs.
function runByRoot
{
    if [[ $(id -u) -ne 0 ]]; then
        echo '[ERROR]: User running script is not root.'
        echo 'Please run script as root user or using "sudo SCRIPT".'
        exit 1
    fi
}


### MAIN:
runByRoot   # Verify if the script is run by root or with sudo command.

# VIRTUALBOX INSTALLATION:
msgPrint "Installing VirtualBox..."

# Verifying VB repository.
if [[ ! -e ${VB_REPO_FILE} ]]; then
    curl ${VB_REPO_URL} -o ${VB_REPO_FILE}    # Download the repository file.
else
    echo "Repository for VirtualBox already configured."
fi

# Verifying if VB is present.
rpm -qi ${VB_PACKAGE_NAME} > /dev/null 2>&1; RC=$?
if [[ ${RC} -ne 0 ]]; then
    ${PKG_MGR} install -y ${VB_DEP_PACKAGE_NAME}    # Install dependency.
    ${PKG_MGR} install -y ${VB_PACKAGE_NAME}        # Install VirtualBox.
else
    echo "VirtualBox already installed."
fi


# VAGRANT INSTALLATION:
msgPrint "Installing Vagrant..."

# Verifying if Vagrant is present.
rpm -qi ${VGRNT_PACKAGE_NAME} > /dev/null 2>&1; RC=$?
if [[ ${RC} -ne 0 ]]; then
    ${PKG_MGR} install -y ${VGRNT_PACKAGE_NAME} # Install Vagrant.
else
    echo "Vagrant already installed."
fi
