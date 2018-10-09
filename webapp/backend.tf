terraform {
  backend "s3" {
    bucket = "bucket-iac-terraform"
    key    = "webapp/terraform.tfstate"
    region = "eu-west-1"
  }
}
