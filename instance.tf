resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
/* influxdb */
resource "aws_instance" "myinstance" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  //subnet_id = "${var.AWS_SUBNET_ID}"
  vpc_security_group_ids = ["sg-0788ef3591272818f"]
  //vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}","${aws_security_group.allow-influxdb.id}","${aws_security_group.allow-influxdb2.id}"]
  tags {
    Name = "influxdb"
    Env = "dev"
    Provisioner = "terraform"
  }
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}
/* Telegraf */
resource "aws_instance" "myinstance2" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  //subnet_id = "${var.AWS_SUBNET_ID}"
  vpc_security_group_ids = ["sg-0788ef3591272818f"]
  tags {
    Name = "telegraf"
    Env = "dev"
    Provisioner = "terraform"
  }
  provisioner "file" {
    source = "script2.sh"
    destination = "/tmp/script2.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script2.sh",
      "sudo /tmp/script2.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}
resource "aws_instance" "myinstance3" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  //subnet_id = "${var.AWS_SUBNET_ID}"
  vpc_security_group_ids = ["sg-0788ef3591272818f"]
  tags {
    Name = "chronograf"
    Env = "dev"
    Provisioner = "terraform"
  }
  provisioner "file" {
    source = "script3.sh"
    destination = "/tmp/script3.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script3.sh",
      "sudo bash /tmp/script3.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}