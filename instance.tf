resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "influxdb-swarm-vm" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  subnet_id = "subnet-054bdd24cfd8cea90"
  private_ip ="${var.influxdb-kapacitor-ip}"
  vpc_security_group_ids = ["sg-00a632f510733c412","sg-0fa551d80897aeec5","sg-0f7cedf536ec89f34","sg-02496b49e8875bd53"]
  tags {
    Name = "influxdb"
    Env = "dev"
    Provisioner = "terraform"
  }
  provisioner "file" {
    source = "scripts/provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostname ${var.influx-hostname}",
      "sudo hostnamectl set-hostname ${var.influx-hostname}",
      "sudo echo ${var.influx-hostname} | sudo tee -a /etc/hostname >/dev/null",
      "sudo echo 127.0.0.1 ${var.influx-hostname} | sudo tee -a /etc/hosts >/dev/null",
      "sudo systemctl restart systemd-logind.service",
      "chmod +x /tmp/provisioner.sh",
      "sudo /tmp/provisioner.sh",
      "sudo service telegraf start"
    ]
  }
   
connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

resource "aws_instance" "swarm-vm" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  subnet_id = "subnet-054bdd24cfd8cea90"
  private_ip = "${var.swarm-worker-ip}"
 vpc_security_group_ids = ["sg-00a632f510733c412","sg-0fa551d80897aeec5","sg-0f7cedf536ec89f34","sg-02496b49e8875bd53"]
  tags {
    Name = "swarm-vm"
    Env = "dev"
    Provisioner = "terraform"
  }
  provisioner "file" {
    source = "scripts/provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }
   provisioner "file" {
    source = "config/cloudwatch/telegraf.conf"
    destination = "/tmp/telegraf.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${aws_instance.influxdb-swarm-vm.private_ip}",
      "sudo hostname ${var.swarm-worker-hostname}",
      "sudo hostnamectl set-hostname ${var.swarm-worker-hostname}",
      "sudo echo ${var.swarm-worker-hostname} | sudo tee -a /etc/hostname >/dev/null",
      "sudo echo ${var.influxdb-kapacitor-ip} ${var.influx-hostname} | sudo tee -a /etc/hosts >/dev/null",
      "sudo echo 127.0.0.1 ${var.swarm-worker-hostname} | sudo tee -a /etc/hosts >/dev/null",
      "sudo systemctl restart systemd-logind.service",
      "chmod +x /tmp/provisioner.sh",
      "sudo /tmp/provisioner.sh",
      "mytoken=`curl ${var.influxdb-kapacitor-ip}`",
      "sudo docker swarm join --token $mytoken ${var.influxdb-kapacitor-ip}:2377",
      "sudo service telegraf stop",
      "sudo cp /tmp/telegraf.conf /etc/telegraf",
      "sudo systemctl daemon-reload",
      "sudo service telegraf start"
    ]
  }

  
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}
resource "aws_instance" "chronograf-swarm-vm" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  subnet_id = "subnet-054bdd24cfd8cea90"
  private_ip = "${var.chronograf-ip}"
  vpc_security_group_ids = ["sg-00a632f510733c412","sg-0fa551d80897aeec5","sg-0f7cedf536ec89f34","sg-02496b49e8875bd53"]
  tags {
    Name = "chronograf"
    Env = "dev"
    Provisioner = "terraform"
  }
   provisioner "file" {
    source = "scripts/chronograf.service"
    destination = "/tmp/chronograf.service"
  }
  provisioner "file" {
    source = "scripts/provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }
  provisioner "file" {
    source = "config/telegraf.conf"
    destination = "/tmp/telegraf.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${aws_instance.influxdb-swarm-vm.private_ip}",
      "sudo hostname ${var.chrono-hostname}",
      "sudo hostnamectl set-hostname ${var.chrono-hostname}",
      "sudo echo ${var.chrono-hostname} | sudo tee -a /etc/hostname >/dev/null",
      "sudo echo ${var.influxdb-kapacitor-ip} ${var.influx-hostname} | sudo tee -a /etc/hosts >/dev/null",
      "sudo echo 127.0.0.1 ${var.chrono-hostname} | sudo tee -a /etc/hosts >/dev/null",
      "sudo systemctl restart systemd-logind.service",
      "chmod +x /tmp/provisioner.sh",
      "sudo /tmp/provisioner.sh",
      "mytoken=`curl ${var.influxdb-kapacitor-ip}`",
      "sudo docker swarm join --token $mytoken ${var.influxdb-kapacitor-ip}:2377",
      "sudo systemctl stop chronograf",
      "sudo service telegraf stop",
      "sudo cp /tmp/chronograf.service /lib/systemd/system",
      "sudo cp /tmp/telegraf.conf /etc/telegraf",
      "sudo systemctl daemon-reload",
      "sudo systemctl start chronograf",
      "sudo service telegraf start"

      
    ]
  }
  
 

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

