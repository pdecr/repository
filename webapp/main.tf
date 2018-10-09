# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}
data "aws_ami" "ubuntu_ami" {
most_recent=true
filter {
    name   = "name"
    values = ["ubuntu*"]
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
    values =["IAC_subnet-0"]
  }
  
}


data "aws_vpc" "vpc_selected" {

     filter {
    name = "tag:Name"
    values =["IAC tooling"]
  }
    
}

