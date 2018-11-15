resource "aws_security_group" "allow-ssh" {
  vpc_id = "vpc-64a1d902"
  name = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "allow-ssh"
  }
}
resource "aws_security_group" "allow-influxdb" {
  vpc_id = "vpc-64a1d902"
  name = "allow-influxdb"
  description = "security group that allows 8086 and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 8086
      to_port = 8086
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "allow-influxdb"
  }
}
resource "aws_security_group" "allow-influxdb2" {
  vpc_id = "vpc-64a1d902"
  name = "allow-influxdb2"
  description = "security group that allows 8088 and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 8088
      to_port = 8088
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "allow-influxdb2"
  }
}