
output "influxdb_pub1" {
  value = "${aws_instance.influxdb-swarm-vm.public_ip}"
}
output "influxdb_priv1" {
  value = "${aws_instance.influxdb-swarm-vm.private_ip}"
}
/*
output "swarm1_pub2" {
  value = "${aws_instance.swarm-vm.public_ip}"
}
output "swarm1_priv2" {
  value = "${aws_instance.swarm-vm.private_ip}"
}
*/
output "chronograf_pub3" {
  value = "${aws_instance.chronograf-swarm-vm.public_ip}"
}
output "chronograf_priv3" {
  value = "${aws_instance.chronograf-swarm-vm.private_ip}"
}
/*
output "swarm-vm-master_pub3" {
  value = "${aws_instance.swarm-vm-master.public_ip}"
}

output "swarm-vm-master_priv3" {
  value = "${aws_instance.swarm-vm-master.private_ip}"
}
*/