This is an example of building a machine image using Packer.
In this template the next will be used:
    - Variables.
    - Amazon EBS builder.
    - SSH communicator.
    - Shell provisioner.
    - File provisioner.
    - Ansible provisioner.

This template execute the following tasks:
    - Through the Shell provisioner, update the system packages and installs Ansible.
    - Through the File provisioner, upload the docker app files.
    - Through the ansible-local provisioner, installs docker and build an docker image inside the machine image.
