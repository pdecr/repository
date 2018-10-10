output "vpc_id" {
  value = "${data.aws_vpc.vpc_selected.id}"
}

output "public_ip_webinstance" {
  value = "${aws_instance.web.*.public_ip}"
}