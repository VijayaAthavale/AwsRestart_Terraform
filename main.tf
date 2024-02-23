# Create a VPC to launch our instances into
resource "aws_vpc" "dev_vpc" {
 cidr_block = "10.0.0.0/16"
 enable_dns_hostnames = true
 enable_dns_support = true
 tags    = {
  name   = "deham10"
 }

}
# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "dev_igw" {
 vpc_id = aws_vpc.dev_vpc.id
 tags    = {
  name   = "deham10"
 }
}
# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
 route_table_id         = aws_vpc.dev_vpc.main_route_table_id
 destination_cidr_block = "0.0.0.0/0"
 gateway_id             = aws_internet_gateway.dev_igw.id
}
# Create a subnet to launch our instances into
resource "aws_subnet" "dev_subnet" {
 vpc_id                  = aws_vpc.dev_vpc.id
 cidr_block              = "10.0.1.0/24"
 map_public_ip_on_launch = true
 availability_zone       = "us-west-2a"
 tags    = {
  name   = "deham10"
 }
}
# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "dev_sg" {
 name        = "deham10"
 description = "Used in the terraform"
 vpc_id      = aws_vpc.dev_vpc.id
 ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]
 }
}
#create EC2 instance
resource "aws_instance" "dev_instance" {
 ami           = "ami-0d442a425e2e0a743"
 instance_type = "t2.micro"
 key_name      = "vockey"
 subnet_id     = aws_subnet.dev_subnet.id
 vpc_security_group_ids = [aws_security_group.dev_sg.id]
 associate_public_ip_address = true
 tags    = {
  name   = "deham10"
 }
}

#user_data = file("userdata.sh")
#user_data = "${base64encode(data.template_file.ec2userdatatemplate.rendered)}"


#provisioner "local-exec" {
 #   command = "echo Instance Type = ${self.instance_type}, Instance ID = ${self.id}, Public IP = ${self.public_ip}, AMI ID = ${self.ami} >> metadata"
 #} 
#}


data "template_file" "ec2userdatatemplate" {
  template = "${file("userdata.tpl")}"
}

output "ec2rendered" {
  value = "${data.template_file.ec2userdatatemplate.rendered}"
}

output "public_ip" {
  #value = aws_instance.instance[0].public_ip
  value = aws_instance.dev_instance.public_ip
}

