This is an example of parallel building a machine image with prometheus configured.
In this template the next will be used:
    - Variables.
    - Amazon EBS builder.
    - LXD builder.
    - SSH communicator.
    - Shell provisioner.
    - File provisioner.
    - Shell provisioner.

This template execute the following tasks:
    - Through the Shell provisioner, runs a script file (init) to download and configure prometheus binaries and directories.
    - Through the File  provisioner, upload the prometheus systemd service file into the machine image.
    - Through the Shell provisioner, runs a script file (post) to start and enable prometheus service.

NOTE:
Since LXD runs 'root' as the user in the container, and in Amazon EBS the user 'ubuntu' is run, scripts are configured to verify the user is running the script.
