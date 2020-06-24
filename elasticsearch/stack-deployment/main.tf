/*
-----------------------------------------------------------------
- This deploys entire application stack
- Environment variable will control the naming convention
- Setup creds and region via env variables
- For more details: https://www.terraform.io/docs/providers/aws
-----------------------------------------------------------------
Notes:
 - control_cidr changes for different modules
 - Instance class also changes for different modules
 - Bastion should be minimum t2.medium as it would be executing config scripts
 - Default security group is added where traffic is supposed to flow between VPC
 */

/********************************************************************************/
provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.9, <= 0.12.24"
  required_providers {
    aws = {
      version = ">= 2.7.0, < 2.55.0"
    }
  }
}



/****
/********************************************************************************/

module "vpc" {
   source                   = "../modules/vpc_pub_private_sub"
#   source                  = "../modules/vpc_public_sub"
   azs                      = "${var.azs}"
   vpc_cidr                 = "${var.vpc_cidr}"
   public_sub_cidr          = "${var.public_sub_cidr}"
   private_sub_cidr         = "${var.private_sub_cidr}"
   enable_dns_hostnames     = true
   vpc_name                 = "${var.vpc_name}-${var.environment}"
   environment              = "${var.environment}"
}

#/*******************************************************
########## ec2 and SG
module "elasticsearch" {
  source 	                        = "../modules/elasticsearch"
  #subnet_id                       = "${module.vpc.aws_subnet.public-subnet[0]}"
  subnet_id                       = "${module.vpc.aws_pub_subnet_id[0]}"
  vpc_id 	                        = "${module.vpc.vpc_id}"
  environment                     = "${var.environment}"
  aws_image                       = "${var.aws_image}"
  aws_instance_type               = "${var.aws_instance_type}"
  associate_public_ip_address     = "${var.associate_public_ip_address}"
  elasticsearch_instance_count    = "${var.elasticsearch_instance_count}"
  elasticsearch_root_volume_size  = "${var.elasticsearch_root_volume_size}"
  elasticsearch_ebs_volume_type   = "${var.elasticsearch_ebs_volume_type}"
  elasticsearch_ebs_volume_size   = "${var.elasticsearch_ebs_volume_size}"
  elasticsearch_service_name      = "${var.elasticsearch_service_name}"
  aws_key_name                    = "${var.aws_key_name}"
}
#*******************************************************/

# ### Configure the backend
# terraform {
#   backend "s3" {
#     bucket  = "Terraform-State"
#     key     = "kafka/${var.region}/dev/terraform.tfstate"
#     region  = "us-west-2"
#   }
# }