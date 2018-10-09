output "vpc_id" {
  value = "${aws_vpc.IAC.id}"
}

output "subnet_id" {
  value = ["${aws_subnet.IAC_subnet.*.id}"]
}
