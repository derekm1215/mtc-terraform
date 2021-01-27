#-----compute/variables.tf

variable "key_name" {}

variable "public_key_path" {}

variable "subnet_ips" {
  type = list(any)
}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group" {}

variable "subnets" {
  type = list(any)
}


variable "db_endpoint" {}

variable "lb_target_group_arn" {}

variable "lb_endpoint" {}