# ---- pcmd networking/main.tf -----

data "aws_availability_zones" "available" {}

resource "aws_vpc" "pc_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "pc_vpc"
  }
}

resource "aws_internet_gateway" "pc_internet_gateway" {
  vpc_id = aws_vpc.pc_vpc.id

  tags = {
    Name = "pc_igw"
  }
}

resource "aws_route_table" "pc_public_rt" {
  vpc_id = aws_vpc.pc_vpc.id

  tags = {
    Name = "pc_public"
  }
}


resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.pc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.pc_internet_gateway.id
}


resource "aws_default_route_table" "pc_private_rt" {
  default_route_table_id = aws_vpc.pc_vpc.default_route_table_id

  tags = {
    Name = "pc_private"
  }
}

resource "aws_subnet" "pc_public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.pc_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "pc_public_${count.index + 1}"
  }
}

resource "aws_subnet" "pc_private_subnet" {
  count      = 3
  vpc_id     = aws_vpc.pc_vpc.id
  cidr_block = var.private_cidrs[count.index]
  # cidr_block              = "${var.cidrs["private1"]}"
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "pc_private_${count.index + 1}"
  }
}

resource "aws_route_table_association" "pc_public_assoc" {
  # count          = "${aws_subnet.pc_public_subnet.count}"
  count          = 2
  subnet_id      = aws_subnet.pc_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.pc_public_rt.id
}

resource "aws_db_subnet_group" "pc_rds_subnetgroup" {
  count      = var.db_subnet_count == "true" ? 1 : 0
  name       = "pc_rds_subnetgroup"
  subnet_ids = aws_subnet.pc_private_subnet.*.id
  tags = {
    Name = "pc_rds_sng"
  }
}

resource "aws_security_group" "pc_public_sg" {
  name        = "pc_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.pc_vpc.id



  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.accessip]
  }

  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.accessip]
  }

  #HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.accessip]
  }

  #VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#RDS Security Group
resource "aws_security_group" "pc_rds_sg" {
  name        = "pc_rds_sg"
  description = "Used for DB instances"
  vpc_id      = aws_vpc.pc_vpc.id
}

resource "aws_security_group_rule" "rds_vpc_ingress" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.pc_rds_sg.id
}

resource "aws_security_group_rule" "rds_control_ingress" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.pc_rds_sg.id
}
