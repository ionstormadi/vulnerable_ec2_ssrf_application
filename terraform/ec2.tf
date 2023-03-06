resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  user_data = file("user_data.sh")
  vpc_security_group_ids = [aws_security_group.ssrf_demo.id]
  user_data_replace_on_change = true

  credit_specification {
    cpu_credits = "unlimited"
  }
}

output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}