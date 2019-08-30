##### VPC Vars
variable "vpc_name" {
  default = "bexs-vpc"
}

variable "cidr_block" {
  default = "10.30.0.0/16"
}

variable "cidr_network_bits" {
  default = "8"
}

variable "subnet_count" {
  default = "1"
}

variable "azs" {
  default = {
    "us-east-1" = "us-east-1a,us-east-1b,us-east-1c,us-east-1d"
  }
}

variable "region" {
  default = "us-east-1"
}

variable "environment" {
  default = "dev"
}


### ASG Vars
variable "elb_name" {
  default = "ebxs-lb"
}

# variable "subnets_ids" {
#   default = ["subnet-62223500", "subnet-c999aebd", "subnet-b82ec0e1"]
# }


variable "elb_idle_timeout" {
  default = 360
}

variable "asg_name" {
  default = "besx-asg"
}

variable "asg_max_size" {
  default = 2
}

variable "asg_min_size" {
  default = 1
}

variable "asg_health_check_grace_period" {
  default = 300
}

variable "health_check_type" {
  default = true
}

variable "desired_capacity" {
  default = 1
}

variable "lc_name" {
  default = "ebxs-lc"
}

variable "ami_id" {
  default = "ami-0cfd34b188b9e7ea0"
}

variable "instance_type" {
  default = "t2.micro"
}


variable "lc_security_groups" {
  default = "sg-03ec7263c3052f63a"
}

variable "iam_role" {
  default = ""
}

variable "key_name" {
  default = "GuiaBolsoSP"
}

variable "sg_name" {
  default = "sonar-elb-sg"
}

variable "ips_sg_list" {
  default = ["0.0.0.0/0"]
}

variable "zone_name" {
  default = "bexs-terraform-test.in."
}

variable "dns_name" {
  default = "bexs"
}

variable "connection_draining" {
  default = true
}

variable "connection_draining_timeout" {
  default = 300
}

variable "listener_port" {
  default = 80
}

variable "listener_protocol" {
  default = "HTTP"
}

variable "target_group_port" {
  default = 8000
}

variable "target_group_health_path" {
  default = "about"
}

variable "target_group_matcher" {
  default = 200
}

variable "health_check_interval" {
  default = 5
}

variable "healthy_threshold" {
  default = 2
}

variable "unhealthy_threshold" {
  default = 2
}

variable "health_check_timeout" {
  default = 3
}

variable "internal" {
  default = false
}

variable "app_name" {
  default = "ebxs-app"
}
