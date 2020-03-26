/*
   Variables for all modules
*/


// Generic
variable "region" {}
variable "azs" {
    default = []
}

// VPC
variable "environment" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_sub_cidr" {
     default = []
}
variable "private_sub_cidr" {
     default = []
}

// Key pair //
variable "aws_key_name" {}
