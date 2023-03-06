variable "network_interface_id" {
  type    = string
  default = "network_id_from_aws"
}

variable "ami" {
  type    = string
  default = "ami-09d3b3274b6c5d4aa"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "public_ip" {
  type = string
}

variable "aws_ec2_connect" {
  type = string
  default = "18.206.107.24/29"
}