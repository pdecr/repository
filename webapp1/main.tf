# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

module "prodwebapp" {
  source = "../module/webapp"

  region               = "eu-west-1"
  subnet_selected_name = ["IAC_subnet2-0", "IAC_subnet2-1"]
  vpc_selected_name    = ["IAC tooling2"]
  ami_ubuntu           = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  ami_packer           = ["ami_packer*"]
  instance_name        = "webInstance2"
  key_pair             = "key_pair"
  instance_type        = "t2.micro"
  elb_tag              = "elbweb"
}
