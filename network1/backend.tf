terraform {
  backend "s3" {
    bucket = "bucket-iac-terraform"
    key    = "vpc2/terraform.tfstate"
    region = "eu-west-1"
  }
}
