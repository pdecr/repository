# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "IAC" {
  cidr_block       = "172.23.0.0/16"
  instance_tenancy = "dedicated"

  tags {
    Name = "IAC tooling"
  }
}

resource "aws_subnet" "IAC_subnet1" {
  vpc_id            = "${aws_vpc.IAC.id}"
  cidr_block        = "172.23.1.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "IAC_subnet1"
  }
}

resource "aws_internet_gateway" "igw_IAC" {
  vpc_id = "${aws_vpc.IAC.id}"

  tags {
    Name = "igw_IAC"
  }
}

resource "aws_route_table" "rtb_IAC" {
  vpc_id = "${aws_vpc.IAC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw_IAC.id}"
  }

  tags {
    Name = "rtb_IAC"
  }
}

resource "aws_route_table_association" "rtb_assoc_IAC" {
  subnet_id      = "${aws_subnet.IAC_subnet1.id}"
  route_table_id = "${aws_route_table.rtb_IAC.id}"
}
