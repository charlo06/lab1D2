provider "aws" {}

resource "aws_vpc" "mVpc" {
  cidr_block = "${var.cidr_vpc}"

  tags = {
    Name = "mVpc"
  }
}

resource "aws_subnet" "mSn" {
  vpc_id     = "${aws_vpc.mVpc.id}"
  cidr_block = "${var.cidr_subnet}"

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

resource "aws_route_table_association" "mRtAssociation" {
  subnet_id      = "${aws_subnet.mSn.id}"
  route_table_id = "${aws_route_table.mRt.id}"
}
