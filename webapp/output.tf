output "vpc_id" {
  value = "${data.aws_vpc.vpc_selected.id}"
}