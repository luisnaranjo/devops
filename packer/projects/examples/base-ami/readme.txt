This is an example of building a machine image using Packer.
In this template the next will be used:
    - Variables.
    - Amazon EBS builder.
    - SSH communicator.
    - Shell provisioner.
    - File provisioner.

This template execute the following tasks:
    - Through the Shell provisioner, installs docker and build an docker image inside the machine image.
    - Through the File and Shell provisioner, installs node_exporter, and start & enable the service.
