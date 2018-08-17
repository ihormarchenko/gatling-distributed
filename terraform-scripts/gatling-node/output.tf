output "instance_private_ips" {
  value = ["${aws_instance.jmeter_slave.*.private_ip}"]
}