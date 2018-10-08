
terraform {
  backend "s3" {
    bucket = "bucket-iac-terraform"
    key    = "vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}
