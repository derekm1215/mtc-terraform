# ----pcmd terraform.tfvars----

#---- resource vars ----

aws_region   = "us-west-2"
project_name = "mtcdev"

#----- Networking Vars ----
vpc_cidr      = "10.123.0.0/16"
public_cidrs  = ["10.123.1.0/24", "10.123.2.0/24"]
private_cidrs = ["10.123.3.0/24", "10.123.4.0/24", "10.123.5.0/24"]
accessip      = "0.0.0.0/0"

#--db vars --
db_instance_class = "db.t2.micro"
dbname            = "rancher"
dbuser            = "admin"
dbpassword        = "w1r3fu1d8"


#--- compute ---
key_name             = "mtckey"
public_key_path      = "/home/ubuntu/.ssh/mtckey.pub"
server_instance_type = "t3.micro"
instance_count       = 1

# ----LB Vars -----
elb_healthy_threshold   = "2"
elb_unhealthy_threshold = "2"
elb_timeout             = "3"
elb_interval            = "30"


