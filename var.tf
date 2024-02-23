
#Public CIDR
variable "CIDR_BLOCK" {
 default =  "0.0.0.0/0"
}
#VPC CIDR
variable "VPC_CIDR" {
    default =  "10.0.0.0/16"
}
#Public Subnet CIDR
variable "PUBLIC_SUBNET_CIDR" {
    default =  "10.0.1.0/24"
}   
#Private Subnet CIDR
variable "PRIVATE_SUBNET_CIDR" {
    default =  "10.0.2.0/24"
}
#Public Subnet CIDR
variable "PUBLIC_SUBNET_CIDR2" {
    default =  "10.0.3.0/24"
}
#Private Subnet CIDR
variable "PRIVATE_SUBNET_CIDR2" {
    default =  "10.0.4.0/24"
}   
#AMI ID
variable "AMI" {
    default =  "ami-0b0dcb5067f052a63"
}
#Instance Type
variable "INSTANCE_TYPE" {
    default =  "t2.micro"
}
#Key Name
variable "KEY_NAME" {
    default =  "vockey"
}
#AWS Region
variable "AWS_REGION" {
    default =  "us-west-2"
}
#AWS Profile
variable "AWS_PROFILE" {
    default =  "default"
}








