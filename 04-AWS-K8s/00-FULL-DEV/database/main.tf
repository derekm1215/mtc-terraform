# ---plantcmd database/main.tf---

resource "aws_db_instance" "plantcmd_db" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7.22"
  instance_class         = var.db_instance_class
  name                   = var.dbname
  username               = var.dbuser
  password               = var.dbpassword
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  identifier             = "pc-rds-masterr"
  skip_final_snapshot    = true
  tags = {
    Name = "pc-master-db"
  }
}