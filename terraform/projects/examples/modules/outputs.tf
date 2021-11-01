output "PrivateIP" {
  description = "The private IP of the EC2 instance."
  value       = aws_instance.my-instance.private_ip
}