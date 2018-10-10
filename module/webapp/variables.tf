variable "region" {}
variable "subnet_selected_name" {
    type = "list"
}

variable "vpc_selected_name" {
    type = "list"
}

variable "instance_name" {
    
}

variable "key_pair"{

}


variable "instance_type"{

}


variable "ami_ubuntu"{
    type = "list"
}

variable "azs" {
  type = "list"

  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "elb_tag"{


}