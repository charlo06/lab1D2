provider "aws" {}

resource "aws_vpc" "mVpc" {
  cidr_block = "${var.cidr_vpc}"

  tags = {
    Name = "mVpc"
  }
}

resource "aws_subnet" "mSn" {
  vpc_id     = "${aws_vpc.mVpc.id}"
  count      = 2
  availability_zone = "${element(var.avaibility_zones, count.index)}"
  cidr_block = "${element(var.cidr_subnet_public,count.index)}"

  tags = {
    Name = "mSn-${count.index}"
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
  count =2
  subnet_id      = "${element(aws_subnet.mSn.*.id,count.index)}"
  route_table_id = "${aws_route_table.mRt.id}"
}
