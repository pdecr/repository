terraform {
  backend "s3" {
    bucket = "bucket-iac-terraform"
    key    = "webapp1/terraform.tfstate"
    region = "eu-west-1"
  }
}
