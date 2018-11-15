output "influxdb_pub1" {
  value = "${aws_instance.myinstance.public_ip}"
}
output "influxdb_priv1" {
  value = "${aws_instance.myinstance.private_ip}"
}
output "telegraf_pub2" {
  value = "${aws_instance.myinstance2.public_ip}"
}
output "telegraf_priv2" {
  value = "${aws_instance.myinstance2.private_ip}"
}
output "chronograf_pub3" {
  value = "${aws_instance.myinstance3.public_ip}"
}
output "chronograf_priv3" {
  value = "${aws_instance.myinstance3.private_ip}"
}