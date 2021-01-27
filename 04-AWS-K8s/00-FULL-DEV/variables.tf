variable "aws_region" {}
variable "project_name" {}

#-------networking variables

variable "vpc_cidr" {}
variable "public_cidrs" {
  type = list(any)
}
variable "private_cidrs" {
  type = list(any)
}
variable "accessip" {}

#-------database variables

variable "db_instance_class" {}
variable "dbname" {}
variable "dbuser" {}
variable "dbpassword" {}

#-------compute variables

variable "key_name" {}
variable "public_key_path" {}
variable "server_instance_type" {}
variable "instance_count" {
  default = 1
}

# LB Vars

variable "elb_interval" {}
variable "elb_timeout" {}
variable "elb_unhealthy_threshold" {}
variable "elb_healthy_threshold" {}
