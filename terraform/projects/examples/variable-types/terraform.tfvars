# STRING TYPE:
variable "my-string" {
  type = string
  default = "Hello"
}

# LIST TYPE - A list of strings:
variable "my-list-string" {
  type    = list(string)                      # Inside the parenthesis you specify the type for the items inside the list.
  default = ["us-west-1a", "us-west-2a"]      # Items are inside square braces.
}

# LIST TYPE - A list of objects:
variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))

  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}
