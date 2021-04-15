This is an example of building a machine image using Packer.
In this template the next will be used:
    - Variables.
    - VirtualBox builder.
    - SSH communicator.
    - Shell provisioner.

This template execute the following tasks:
    - Through the VirtualBox builder, it will create a virtual machine (for image generation) based on Alpine, and specify boot commands at ISO installation time.
    - Through the Shell provisioner, once the virtual machine is created, it will update the system packages.
