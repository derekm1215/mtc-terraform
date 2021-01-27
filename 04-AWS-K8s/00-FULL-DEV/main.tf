# ---plantcmd main.tf ---

provider "aws" {
  region = var.aws_region
}

# Deploy Networking Resources

module "networking" {
  source          = "./networking"
  db_subnet_count = "true"
  vpc_cidr        = var.vpc_cidr
  public_cidrs    = var.public_cidrs
  private_cidrs   = var.private_cidrs
  accessip        = var.accessip
}

# Deploy Data Resources

module "database" {
  source                 = "./database"
  db_instance_class      = "db.t2.micro"
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  db_subnet_group_name   = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = module.networking.vpc_security_group_ids
}

# Deploy Compute Resources

module "compute" {
  source              = "./compute"
  instance_count      = 2
  key_name            = "pcmdKey"
  public_key_path     = var.public_key_path
  instance_type       = "t3.micro"
  subnets             = module.networking.public_subnets
  security_group      = module.networking.public_sg
  subnet_ips          = module.networking.subnet_ips
  db_endpoint         = module.database.db_endpoint
  lb_target_group_arn = module.loadbalancer.lb_target_group_arn
  lb_endpoint         = module.loadbalancer.lb_endpoint
}

# Deploy Load Balancer
module "loadbalancer" {
  source                  = "./loadbalancer"
  elb_healthy_threshold   = var.elb_healthy_threshold
  elb_unhealthy_threshold = var.elb_unhealthy_threshold
  elb_timeout             = var.elb_timeout
  elb_interval            = var.elb_interval
  public_sg               = module.networking.public_sg
  project_name            = var.project_name
  pc_vpc                  = module.networking.pc_vpc
  public_subnets          = module.networking.public_subnets
  pc_nodes                = module.compute.pc_nodes
}

# # DNS
# module "dns" {
#   source     = "../dns"
#   pc_lb      = "${module.loadbalancer.pc_lb}"
#   pc_pritunl = "${module.pritunl.pc_pritunl}"
# }

#HELM
# module "helm" {
#   source = "../helm"
# }










