#load balancer main.tf

resource "aws_lb" "pc_lb" {
  name            = "pc-loadbalancer"
  subnets         = var.public_subnets
  security_groups = [var.public_sg]
  idle_timeout    = 400
}

resource "aws_lb_target_group" "pc_tg" {
  name     = "pc-lb-tg-${substr(uuid(), 0, 3)}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.pc_vpc
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }

  health_check {
    healthy_threshold   = var.elb_healthy_threshold
    unhealthy_threshold = var.elb_unhealthy_threshold
    timeout             = var.elb_timeout
    interval            = var.elb_interval
  }
}

resource "aws_lb_listener" "pc_lb_listener" {
  load_balancer_arn = aws_lb.pc_lb.arn
  port              = 8000
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:acm:us-west-2:705795420405:certificate/b23dab98-1bd1-47e7-b5b8-4e44197afe22"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pc_tg.arn
  }
}

