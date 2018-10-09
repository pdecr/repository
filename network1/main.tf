# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
} 

module "prod" {
  source = "../module/vpc"
  region = "eu-west-1"

  cidr_blockVPC = "10.1.0.0/16"
  tag_nameVPC   = "IAC tooling2"

  tag_nameSubnet   = "IAC_subnet2"
  cidr_blockSubnet = ["10.1.1.0/24", "10.1.10.0/24"]

  tag_nameigw = "igw_IAC2"
  tag_namertb = "rtb_IAC2"
}
