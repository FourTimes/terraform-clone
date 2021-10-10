variable "ami" {}
variable "availability_zone" {}
variable "iam_instance_profile" {}
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "additional_tags" { type = map(string) }
variable "security_group_name" {}
variable "ingress_rule" { type = map(list(string)) }
