output "vpc_id" {
  value = "${aws_vpc.IAC.id}"
}

output "subnet1_id" {
  value = "${aws_subnet.IAC_subnet1.id}"
}
