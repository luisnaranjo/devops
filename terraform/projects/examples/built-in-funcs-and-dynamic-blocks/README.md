# Terraform Example - Built-in functions & Dynamic blocks.
This Terraform configuration project is an example of using built-in functions & Dynamic blocks.

The terraform configuration will create an Apache web server in a EC2 instance. We will make use of dynamic blocks for creating a security group's ingress rules. And some built-in functions for the SG name, user-data script file, and output information.
This project consists of several files:
- `main.tf`: Contains the main Terraform configuration for the module.
- `variables.tf`: Variable definitions.
- `outputs.tf`: Outputs of the module.
- `script.sh`: The user-data (cloud-init) script for bootstrapping the Web Server.