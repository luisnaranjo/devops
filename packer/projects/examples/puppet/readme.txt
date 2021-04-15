This is an example of building a machine image using Packer.
In this template the next will be used:
    - Variables.
    - Amazon EBS builder.
    - SSH communicator.
    - Shell provisioner.
    - File provisioner.
    - Puppet provisioner.

This template execute the following tasks:
    - Through the Shell provisioner, update the system packages and configures Puppet.
    - Through the File provisioner, upload the docker app files.
    - Through the puppet-masterless provisioner, installs docker and build an docker image inside the machine image.
