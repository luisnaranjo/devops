#! /usr/bin/env bash

# Script:       ansible-setup.sh
# Author:       Luis Antonio Naranjo Mora.
# Description:  Bash script for initial Ansible setup. This setup is designed for Ansible to be used in the local-machine (no controlled nodes).
# Targets:      Linux Red Hat-based systems.
# Return codes:
#   - 0: Executiong successful.
#   - 1: User running script is not root.

# VARIABLES:
PKG_MGR='dnf'                                         # Specify the package manager to be used.

ANSIBLE_SUDO='/etc/sudoers.d/ansible'                 # Sudo file for Ansible's user.

ANSIBLE_SSH_HOME='/home/ansible/.ssh'                 # Specify the SSH directory of ansible.
ANSIBLE_SSH_FILE="$ANSIBLE_SSH_HOME/id_rsa"           # Specify the SSH-RSA private key file.
ANSIBLE_SSH_FILE_PUB="$ANSIBLE_SSH_HOME/id_rsa.pub"   # Specify the SSH-RSA public key file.
ANSIBLE_SSH_AUTHK="$ANSIBLE_SSH_HOME/authorized_keys" # Specify the SSH authorized_keys file.

ANSIBLE_COLLECTION_GENE='community.general'	      # Specify the needed Ansible Collection for installation via Ansible Galaxy.
ANSIBLE_COLLECTION_KUBE='community.kubernetes'
ANSIBLE_COLLECT_PATH='/usr/share/ansible/collections' # Specify the installation path for Ansible Collections.



# FUNCTIONS:
function msgPrint
{
  echo -e "\n###################################"
  echo $1
}



# MAIN:
# Verify if user running the script is root.
if [[ $(id -u) -ne 0 ]]; then
  echo '[ERROR]: User running script is not root.'
  echo 'Please run script as root user or using "sudo SCRIPT".'
  exit 1
fi

# Update current system state.
msgPrint "Updating system packages..."
${PKG_MGR} update -y


# Verify ansible installation, and installed if not present.
msgPrint "Verifying Ansible installation..."
${PKG_MGR} list installed ansible >/dev/null 2>&1; RC=$?

if [[ $RC -ne 0 ]]; then
  echo "Ansible not installed. Starting installation..."
  ${PKG_MGR} install -y ansible
else
  echo "Ansible already installed."
fi


# Set Ansible's user if not present.
msgPrint "Configuring Ansible's user..."
id ansible > /dev/null 2>&1; RC=$?
if [[ $RC -ne 0 ]]; then
  useradd ansible
  passwd ansible
else
  echo "Ansible's user already configured."
fi

# Set elevated permissions to Ansible's user only if file doesn't exists and if it's not empty.
# This only applies on the local node. It doesn't set it in the controlled nodes.
if [[ ! -s $ANSIBLE_SUDO ]]; then
  echo 'Adding ansible to sudoers...'
  echo '# Adding sudo access to ansible user without password.' > $ANSIBLE_SUDO
  echo -e 'ansible\t\tALL=(ALL)\t\tNOPASSWD: ALL' > $ANSIBLE_SUDO
else
  echo 'ansible already in sudoers.'
fi

# Generate ansible's ssh keys. Will prompt for passphrase (Optional).
# RSA Key of 3072 bits.
if [[ ! -e $ANSIBLE_SSH_FILE || ! -e $ANSIBLE_SSH_FILE_PUB ]]; then
  echo 'Generating ssh-rsa keys for ansible.'
  sudo -u ansible ssh-keygen -t rsa -b 3072
else
  echo 'ssh-rsa keys for ansible already set.'
fi

# Install Ansible Collections for modules outside of the built-in Ansible collection.
msgPrint "Setting external Ansible collections..."
ansible-galaxy collection install ${ANSIBLE_COLLECTION_GENE} -p ${ANSIBLE_COLLECT_PATH}
ansible-galaxy collection install ${ANSIBLE_COLLECTION_KUBE} -p ${ANSIBLE_COLLECT_PATH}

# When working with controlled nodes, remember the next steps:
#   - Modify the /etc/hosts file for adding the controlled nodes.
#   - Modify the ansible default inventory for adding the controlled nodes.
#   - Copy the 'ansible' ssh keys into the controlled nodes.
