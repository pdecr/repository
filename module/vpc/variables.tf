variable "region" {}

variable "cidr_blockVPC" {}

variable "tag_nameVPC" {}

variable "cidr_blockSubnet" {
  type = "list"
}

variable "tag_nameSubnet" {}

variable "tag_nameigw" {}

variable "tag_namertb" {}

variable "azSubnet" {
  type = "list"

  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}
