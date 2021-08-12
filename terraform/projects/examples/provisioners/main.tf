## Example Project: provisioner.
# Description: This is an example of setting a provisioner on a resource.
#              The provisioner is a create, local provisioner. Which means, as soon as the resource is created, the provisioner is going to run and execute the command in the same directory where the Terraform command was executed.


# The 'null_resource' resource implements the standard resource lifecycle, but takes no further action.
resource "null_resource" "dummy_resource" {
  # Local provisioner.
  provisioner "local-exec" {
    #when    = destroy   # This property sets the provisioner to be a destroy provisioner.
    command = "echo '0' > status.txt" # Shell bash command.
  }
}
