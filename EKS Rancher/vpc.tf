#VPC
resource "aws_vpc" "nem-vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = "${var.prefix}-vpc"
  }

}

#Create public subnets
resource "aws_subnet" "subnets" {
 count      = 2
 vpc_id     = aws_vpc.nem-vpc.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 map_public_ip_on_launch = true
 
 tags = {
   Name = "${var.prefix}-SubnetPB${count.index + 1}"
 }
}

#Create private subnets
resource "aws_subnet" "subnets2" {
 count      = 2
 vpc_id     = aws_vpc.nem-vpc.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 map_public_ip_on_launch = true
 
 tags = {
   Name = "${var.prefix}-SubnetPV-${count.index + 1}"
 }
}