provider "aws" {}

resource "aws_vpc" "mVpc" {
  cidr_block = "172.23.0.0/16"

  tags = {
    Name = "mVpc"
  }
}

resource "aws_subnet" "mSn" {
  vpc_id     = "${aws_vpc.mVpc.id}"
  cidr_block = "172.23.1.0/24"

  tags = {
    Name = "mSn"
  }
}
