#------networking/variables.tf

variable "vpc_cidr" {}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}

variable "accessip" {}

variable "db_subnet_count" {}
