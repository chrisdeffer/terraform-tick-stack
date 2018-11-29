resource "aws_security_group" "allow-ssh" {
  vpc_id = "${aws_vpc.main.id}"
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
  vpc_id = "${aws_vpc.main.id}"
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
  vpc_id = "${aws_vpc.main.id}"
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

resource "aws_security_group" "allow-docker-swarm-ports" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-docker-swarm-ports"
  description = "security group that allows docker swarm ports 2377 4789 7946"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 2377
      to_port = 2377
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
      from_port = 4789
      to_port = 4789
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
      from_port = 7946
      to_port = 7946
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "allow-docker-swarm-ports"
  }
}