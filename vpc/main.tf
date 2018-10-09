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

resource "aws_subnet" "IAC_subnet" {
  count = 2
   # This will create 2 subnets
  vpc_id            = "${aws_vpc.IAC.id}"
  cidr_block        = "${element(var.cidr_blockSubnet,count.index)}"
  availability_zone = "${element(var.azSubnet, count.index)}"

   
  tags {
    Name = "${var.tag_nameSubnet}-${count.index}"
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
  count          = 2
  subnet_id      = "${element(aws_subnet.IAC_subnet.*.id,count.index)}"
  route_table_id = "${aws_route_table.rtb_IAC.id}"
  
}
