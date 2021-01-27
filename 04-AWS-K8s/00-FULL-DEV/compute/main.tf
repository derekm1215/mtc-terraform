#----- plantcmd compute/main.tf------

data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "random_id" "pc_node_id" {
  byte_length = 2
  count       = var.instance_count
}

resource "aws_key_pair" "pc_auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

data "template_file" "user-init" {
  count    = var.instance_count
  template = file("${path.module}/userdata.tpl")

  vars = {
    nodename    = "pc-${random_id.pc_node_id[count.index].dec}"
    db_endpoint = var.db_endpoint
    lb_endpoint = var.lb_endpoint
  }
}

resource "aws_instance" "pc_node" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.server_ami.id

  tags = {
    Name = "pc_node-${random_id.pc_node_id[count.index].dec}"
  }

  key_name               = aws_key_pair.pc_auth.id
  vpc_security_group_ids = [var.security_group]
  subnet_id              = element(var.subnets, count.index)
  user_data              = data.template_file.user-init.*.rendered[count.index]

  root_block_device {
    volume_size = 20
  }
}

resource "aws_lb_target_group_attachment" "pc_tg_attach" {
  count            = var.instance_count
  target_group_arn = var.lb_target_group_arn
  target_id        = aws_instance.pc_node[count.index].id
  port             = 8008
}



