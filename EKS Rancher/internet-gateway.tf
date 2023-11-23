#Public Network configuration
resource "aws_internet_gateway" "k8s-igw" {
  vpc_id     = aws_vpc.nem-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

#RTB
resource "aws_route_table" "k8s-rtb" {
  vpc_id     = aws_vpc.nem-vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.k8s-igw.id
  }
    tags = {
    Name = "${var.prefix}-rtb"
  }
}

##Association RTB on SUBNET
resource "aws_route_table_association" "new-rtb-association" {
    count = 2
    route_table_id = aws_route_table.k8s-rtb.id
    subnet_id = aws_subnet.subnets.*.id[count.index]
}

##Association RTB on SUBNET
resource "aws_route_table_association" "new-rtb-association2" {
    count = 2
    route_table_id = aws_route_table.k8s-rtb.id
    subnet_id = aws_subnet.subnets2.*.id[count.index]
}

#Worker public ips
resource "aws_eip" "eks_eip" {
  count = 2
  domain   = "vpc"
  
  tags = {
    "Name" = format("%s-elastic-ip", var.cluster_name)
  }

}

#NAT gateway configs
resource "aws_nat_gateway" "eks_nat_gw" {
  count = 2
  allocation_id = aws_eip.eks_eip.*.id[count.index]
  subnet_id = aws_subnet.subnets.*.id[count.index]

  tags = {
    Name = format("%s-nat-gateway", var.cluster_name)
  }

}

resource "aws_route_table" "eks_nat_rt" {
  count = 2
  vpc_id  = aws_vpc.nem-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat_gw.*.id[count.index]
  }

  tags = {
    Name = format("%s-private-rt", var.cluster_name)  
  }

}