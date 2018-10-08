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
  vpc_id     = "${aws_vpc.IAC.id}"
  cidr_block = "172.23.1.0/24"

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
