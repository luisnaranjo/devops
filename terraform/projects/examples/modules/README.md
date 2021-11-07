# Terraform Example - Modules.
This Terraform configuration project is an example of declaring and using modules.
This project consists of a root module composed only of the `main.tf` and an `outputs.tf` file.

Inside the `modules` directory we have the module called `vpc`. This directory is composed of 3 files for the vpc module:
- `main.tf`: Contains the main Terraform configuration for the module.
- `variables.tf`: Module's variable definition.
- `outputs.tf`: Outputs of the module.