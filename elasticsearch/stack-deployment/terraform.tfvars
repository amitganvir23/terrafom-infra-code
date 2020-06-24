/*
 Variables for deploying stack
--------------------------------
*/

// ## General Variables
region            = "us-east-1"
azs               = ["us-east-1a","us-east-1b","us-east-1c"]
vpc_name          = "my-Infra"
vpc_cidr          = "192.168.0.0/16"
environment       = "dev"

/* Classes of instances - has to change based on environment
- Please choose between the following only
- [test|dev|qa|stage]
*/

# AZs are combintation of az length + subnet cidrs
public_sub_cidr   = ["192.168.0.0/24","192.168.1.0/24"]
private_sub_cidr  = ["192.168.3.0/24","192.168.4.0/24"]
associate_public_ip_address = "true"

// AWS Key Pair //
aws_key_name = "desktop-key"


## [ Root Volume type ]
root_volume_type = "gp2"
delete_on_termination = true


## Kafka Variables //
aws_image          = "ami-01d025118d8e760db"  # Amazon Linux 2 AMI OR RHEL
aws_instance_type  = "t2.micro"
  
// ==== Broker/Kafka =====
## [ Number of instances to launch ]
elasticsearch_instance_count   = 1
## [ Root Volume size ]
elasticsearch_root_volume_size = 8
## [ EBS Volume type and size ]
elasticsearch_ebs_volume_type  = "gp2"
elasticsearch_ebs_volume_size  = 8
## [ Service name for sg,volume,ec2,nw tag] 
elasticsearch_service_name     = "elasticsearch"

