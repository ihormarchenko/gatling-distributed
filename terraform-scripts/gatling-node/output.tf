output "instance_private_ips" {
  value = ["${aws_instance.gatling-node.*.private_ip}"]
}
