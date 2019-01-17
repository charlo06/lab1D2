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

resource "aws_internet_gateway" "mIgw" {
  vpc_id = "${aws_vpc.mVpc.id}"

  tags = {
    Name = "mIgw"
  }
}

resource "aws_route_table" "mRt" {
  vpc_id = "${aws_vpc.mVpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.mIgw.id}"
  }

  tags = {
    Name = "mRt"
  }
}
