output "vpc-pubsub1" {
  value = "${aws_subnet.main-public-1.id}"
}
output "vpc-pubsub2" {
  value = "${aws_subnet.main-public-2.id}"
}
output "vpc-privsub1" {
  value = "${aws_subnet.main-private-1.id}"
}
output "vpc-privsub2" {
  value = "${aws_subnet.main-private-2.id}"
}

output "vpc-id" {
  value = "${aws_vpc.main.id}"
}

output "vpc-security-grp-allow-ssh" {
  value = "${aws_security_group.allow-ssh.id}"
}
output "vpc-security-grp-allow-influx" {
  value = "${aws_security_group.allow-influxdb.id}"
}
output "vpc-security-grp-allow-influx2" {
  value = "${aws_security_group.allow-influxdb2.id}"
}
output "vpc-security-grp-allow-docker-swarm" {
  value = "${aws_security_group.allow-docker-swarm-ports.id}"
}

