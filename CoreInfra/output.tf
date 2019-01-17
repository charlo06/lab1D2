output "vpcId" {
  value = "${aws_vpc.mVpc.id}"
}

output "subnetId" {
  value = "[${aws_subnet.mSn.id}]"
}
