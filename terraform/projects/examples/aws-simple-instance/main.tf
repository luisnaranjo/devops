provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-vm" {
  ami = "ami-0c2b8ca1dad447f8a"
  subnet_id = "subnet-01b97eb4f0f8ab595"
  instance_type = "t3.micro"

  tags = {
    Name = "tf-instance"
    Terraform = "true"
  }
}
