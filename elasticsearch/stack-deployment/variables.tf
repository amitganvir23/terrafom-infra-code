/*
   Variables for all modules
*/


// Generic
variable "region" {}
variable "azs" {
    default = []
}

// VPC
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_sub_cidr" {
     default = []
}
variable "private_sub_cidr" {
     default = []
}


// Genral variables //
variable "environment" {}


// Key pair //
variable "aws_key_name" {}


# // 
variable "aws_image" {}
variable "aws_instance_type" {}
variable "associate_public_ip_address" {}

// Root Volume
variable "root_volume_type" {
  default = "gp2"
}


// ==== elasticsearch =====
variable "elasticsearch_instance_count" {}
variable "elasticsearch_root_volume_size" {}
variable "elasticsearch_ebs_volume_type" {}
variable "elasticsearch_ebs_volume_size" {}
variable "elasticsearch_service_name" {}

