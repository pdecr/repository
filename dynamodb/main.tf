
# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}

resource "aws_dynamodb_table" "tfstate-dynamodb-table" {
  name           = "tfstate"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

    attribute {
    name="LockID"
    type="S"

    }
  }


