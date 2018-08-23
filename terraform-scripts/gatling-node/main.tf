# Configure the AWS Provider
provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

resource "aws_instance" "gatling-node" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  iam_instance_profile = "${var.iam_instance_profile}"
  tags {
    Name = "gatling-node"
    Type = "gatling-node"
    Env = "${var.env}"
  }
  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  key_name = "${aws_key_pair.performance-qa.key_name}"
  
  count = "${var.count}"
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("${path.module}/ssh-key/id_rsa_terraform")}"
  }
  
  provisioner "file" {
    source      = "/${path.module}/logstash.tar"
    destination = "~/logstash.tar"
  }

  provisioner "file" {
    source      = "/${path.module}/gatling-node.tar"
    destination = "~/gatling-node.tar"
  }
    
  provisioner "remote-exec" {
    inline = [
      "cd ~",
      "docker load -i fluentd.tar",
      "docker run -d --name fluentd -e TEST_ENV=${var.env} -v jmeter-logs:/jmeter-logs/ -v gatling-logs:/gatling-logs/ fluent/fluentd",
      "docker load -i gatling-node.tar"
    ]
  }

}

resource "aws_key_pair" "performance-qa" {
  key_name_prefix   = "terraform"
  public_key = "${file("${path.module}/ssh-key/id_rsa_terraform.pub")}"
}
