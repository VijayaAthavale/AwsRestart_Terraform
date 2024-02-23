locals {
    #Name of the vpc
  Name="awsRestartVPC"

}

#Create VPC with tag awsRestartVPC
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.VPC_CIDR
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  instance_tenancy = "default"
  tags = {
    Name = "awsRestartVPC"
  }
}
#Create Internet Gateway with tag awsRestartIGW
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "awsRestartIGW"
  }
}
#Create Route Table with tag awsRestartRT
resource "aws_route_table" "dev_rt" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "awsRestartRT"
  }
}
#Create Route with tag awsRestartRoute
resource "aws_route" "dev_route" {
  route_table_id = aws_route_table.dev_rt.id
  destination_cidr_block = var.CIDR_BLOCK
  gateway_id = aws_internet_gateway.dev_igw.id
}
#Create Public Subnet1 with tag awsRestartSubnet
resource "aws_subnet" "dev_subnet" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = var.PUBLIC_SUBNET_CIDR
  tags = {
    Name = "awsRestartSubnet"
  }
}
#Associate Public Subnet1 with Route Table
resource "aws_route_table_association" "dev_rt_association" {
    subnet_id = aws_subnet.dev_subnet.id
  route_table_id = aws_route_table.dev_rt.id
}
#Create Security Group with tag awsRestartSG
resource "aws_security_group" "dev_sg" {
  name = "awsRestartSG"
  vpc_id = aws_vpc.dev_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.CIDR_BLOCK]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "Http"
    cidr_blocks = [var.CIDR_BLOCK]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.CIDR_BLOCK]
  }
  tags = {
    Name = "awsRestartSG"
  }
}


