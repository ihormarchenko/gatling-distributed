variable "aws_region" {
    default = "us-east-1"
}
variable "ami" {
    default = "ami-c68c88b9"
}

variable "iam_instance_profile" {
    default = "gatling-node"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "env" {
}

variable "subnet_id" {
}

variable "vpc_security_group_ids"{
    type = "list"
}

variable "aws_profile" {
  default = "ring-dev"
}

variable "count" {
  default = 1
}
