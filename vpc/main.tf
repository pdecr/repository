# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "IAC" {
  cidr_block = "${var.cidr_blockVPC}"

  tags {
    Name = "${var.tag_nameVPC}"
  }
}

resource "aws_subnet" "IAC_subnet1" {
  vpc_id            = "${aws_vpc.IAC.id}"
  cidr_block        = "${var.cidr_blockSubnet}"
  availability_zone = "${var.azSubnet}"

  tags {
    Name = "${var.tag_nameSubnet}"
  }
}

resource "aws_internet_gateway" "igw_IAC" {
  vpc_id = "${aws_vpc.IAC.id}"

  tags {
    Name = "${var.tag_nameigw}"
  }
}

resource "aws_route_table" "rtb_IAC" {
  vpc_id = "${aws_vpc.IAC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw_IAC.id}"
  }

  tags {
    Name = "${var.tag_namertb}"
  }
}

resource "aws_route_table_association" "rtb_assoc_IAC" {
  subnet_id      = "${aws_subnet.IAC_subnet1.id}"
  route_table_id = "${aws_route_table.rtb_IAC.id}"
}
