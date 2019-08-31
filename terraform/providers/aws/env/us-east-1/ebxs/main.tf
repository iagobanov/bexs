provider "aws" {
  region = "us-east-1"
}

//The key is like this because we alter with SED in the Jenkins Pipeline
# terraform {
#   backend "s3" {
#     region  = "sa-east-1"
#     bucket  = "enablers-team"
#     key     = "tf-states/SATIVEX/sonar.tfstate"
#     encrypt = true
#   }
# }

module "vpc" {
  source   = "../../../../../modules/vpc"
  cidr_vpc = "${var.cidr_block}"
  vpc_name = "${var.vpc_name}"
}

module "aws_security_group" {
  source      = "../../../../../modules/security_group/create_sg"
  sg_name     = "${var.sg_name}"
  vpc_id      = "${module.vpc.vpc_id}"
}

module "sg_rules_https" {
  source            = "../../../../../modules/security_group/create_sg_rule"
  port              = 80
  protocol          = "TCP"
  ips_sg_list       = "${var.ips_sg_list}"
  security_group_id = "${module.aws_security_group.id}"
}


module "application_loadbalancer" {
  source           = "../../../../../modules/alb/aws_lb"
  name             = "alb-${var.app_name}"
  internal         = false
  security_groups  = ["${module.aws_security_group.id}"]
  internal_subnets = ["${module.vpc.public_subnets}", "${module.vpc.private_subnets}"]
  external_subnets = ["${module.vpc.public_subnets}", "${module.vpc.private_subnets}"]  
}

module "loadbalancer_lister_http" {
  source            = "../../../../../modules/alb/aws_lb_listener"
  load_balancer_arn = "${module.application_loadbalancer.alb_arn}"
  target_group_arn  = "${module.target_group.alb_tg_arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"
  ssl_certificate   = ""
  certificate_arn   = ""
}

module "target_group" {
  source                = "../../../../../modules/alb/aws_lb_target_group"
  name                  = "${var.asg_name}"
  port                  = "${var.target_group_port}"
  vpc_id                = "${module.vpc.vpc_id}"
  path                  = "${var.target_group_health_path}"
  matcher               = "${var.target_group_matcher}"
  health_check_interval = "${var.health_check_interval}"
  healthy_threshold     = "${var.healthy_threshold}"
  unhealthy_threshold   = "${var.unhealthy_threshold}"
  health_check_timeout  = "${var.health_check_timeout}"
}

module "aws_launch_configuration" {
  source          = "../../../../../modules/launch_config"
  lc_name         = "${var.lc_name}"
  ami_id          = "${var.ami_id}"
  instance_type   = "${var.instance_type}"
  path_user_data  = "./user_data.sh"
  security_groups = "${module.aws_security_group.id}"
  iam_role        = "${var.iam_role}"
  key_name        = "${var.key_name}"
}

module "aws_autoscaling_group_tg" {
  source                    = "../../../../../modules/asg"
  asg_name                  = "${var.asg_name}-tg"
  associate_elb             = "TG"
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "ELB"
  desired_capacity          = "${var.desired_capacity}"
  lc_name                   = "${module.aws_launch_configuration.lc_name}"
  subnets_id                = ["${module.vpc.asg_public_subnets}"]
  target_group_arns         = ["${module.target_group.alb_tg_arn}"]
}

module "aws_route_53" {
  source         = "../../../../../modules/route_53"
  routing_policy = "Simple"
  zone_id        = "${module.vpc.zone_id}"
  name           = "${var.dns_name}"
  type           = "CNAME"
  records        = "${module.application_loadbalancer.dns_name}"
}
