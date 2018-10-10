# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}
data "aws_ami" "ubuntu_ami" {
most_recent=true
filter {
    name   = "name"
    values = "${var.ami_ubuntu}"
  }
}

data "template_file" "init" {
  template = "${file("${path.module}/lab00/webapp/userdata.tpl")}"

   vars {
    username = "pdecr"
  }
}
data "aws_vpc" "vpc_selected" {

    filter {
    name = "tag:Name"
    values = "${var.vpc_selected_name}"
  }
    
}

data "aws_subnet_ids" "subnets" {
  vpc_id = "${data.aws_vpc.vpc_selected.id}"
}



resource "aws_instance" "web" {
  count = 2
  ami           = "${data.aws_ami.ubuntu_ami.id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids=["${aws_security_group.web_sg.id}"]
  key_name ="${var.key_pair}"
  subnet_id="${element(data.aws_subnet_ids.subnets.ids,count.index)}"


  associate_public_ip_address=true
  tags {
    Name = "${var.instance_name}-${count.index}"
  }

  user_data = "${data.template_file.init.rendered}"
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow all web traffic"
  vpc_id      = "${data.aws_vpc.vpc_selected.id}"
  

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
}

# Create a new load balancer
resource "aws_elb" "elbweb" {
  name               = "elbweb"
  
  security_groups=["${aws_security_group.web_sg.id}"]
  subnets=["${data.aws_subnet_ids.subnets.ids}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

 

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.web.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "${var.elb_tag}"
  }
}

