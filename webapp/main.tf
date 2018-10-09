# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}
data "aws_ami" "ubuntu_ami" {
most_recent=true
filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "template_file" "init" {
  template = "${file("${path.module}/lab00/webapp/userdata.tpl")}"

   vars {
    username = "pdecr"
  }
}


data "aws_subnet" "subnet_selected" {

    filter {
    name = "tag:Name"
    values ="${var.subnet_selected_name}"
  }
  
}


data "aws_vpc" "vpc_selected" {

     filter {
    name = "tag:Name"
    values = "${var.vpc_selected_name}"
  }
    
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




resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu_ami.id}"
  instance_type = "t2.micro"
  security_groups=["${aws_security_group.web_sg.id}"]
  key_name ="${var.key_pair}"
  subnet_id="${data.aws_subnet.subnet_selected.id}"
  associate_public_ip_address=true
  tags {
    Name = "${var.instance_name}"
  }

  user_data = "${data.template_file.init.rendered}"
}