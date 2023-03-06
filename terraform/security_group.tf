resource "aws_security_group" "ssrf_demo" {
  name        = "ssrf_demo"
  description = "Allow TLS inbound traffic"
  tags = {
    Name = "ssrf_demo"
  }
}

resource "aws_security_group_rule" "https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ssrf_demo.id
  cidr_blocks = [var.public_ip]
}

resource "aws_security_group_rule" "http_8000" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  security_group_id = aws_security_group.ssrf_demo.id
  cidr_blocks = [var.public_ip]
}

resource "aws_security_group_rule" "http_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.ssrf_demo.id
  cidr_blocks = [var.public_ip]
}

resource "aws_security_group_rule" "aws_ec2_connect" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ssrf_demo.id
  cidr_blocks = [var.aws_ec2_connect]
}

resource "aws_security_group_rule" "allow_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ssrf_demo.id
  cidr_blocks = ["0.0.0.0/0"]
}

