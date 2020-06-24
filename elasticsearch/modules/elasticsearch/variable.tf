
/*
   Variables for all modules
*/


// Generic
#variable "region" {}
# variable "azs" {
#     default = []
# }

// Key pair //
variable "aws_key_name" {}


# // VPC
variable "vpc_id" {}
variable "subnet_id" {}

# variable "subnet_id" {
#     default = []
# }

# variable "vpc_cidr" {}

// Genral variables //
variable "environment" {}



# // 
 //
variable "aws_image" {}
variable "aws_instance_type" {}
variable "associate_public_ip_address" {}

// Root Volume
variable "root_volume_type" {
  default = "gp2"
}


#====================
// ==== elasticsearch =====
variable "elasticsearch_instance_count" {}
variable "elasticsearch_root_volume_size" {}
variable "elasticsearch_ebs_volume_type" {}
variable "elasticsearch_ebs_volume_size" {}
variable "elasticsearch_service_name" {}
