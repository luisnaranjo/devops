This is an example of building a machine image using Packer.
In this template the next will be used:
    - Variables.
    - Amazon EBS builder.
    - SSH communicator.
    - Shell provisioner.
    - File provisioner.
    - Salt provisioner.

This template execute the following tasks:
    - Through the Shell provisioner, update the system packages. Creates the /srv/pillar & /srv/salt directories, and changes ownership of directory to ubuntu:ubuntu.
    - Through the File provisioner, upload the salt and pillar directories into their respective /srv locations.
    - Through Salt provisioner, configures the web application.
