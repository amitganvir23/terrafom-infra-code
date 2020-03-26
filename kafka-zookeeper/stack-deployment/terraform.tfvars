/*
 Variables for deploying stack
--------------------------------
*/

// ## General Variables
region            = "us-east-1"
azs               = ["us-east-1a","us-east-1b","us-east-1c"]
vpc_name          = "Kafka-Infra"
vpc_cidr          = "192.168.0.0/16"
environment       = "dev"

/* Classes of instances - has to change based on environment
- Please choose between the following only
- [test|dev|qa|stage]
*/

# AZs are combintation of az length + subnet cidrs
public_sub_cidr   = ["192.168.0.0/24","192.168.1.0/24"]
private_sub_cidr  = ["192.168.3.0/24","192.168.4.0/24"]

// AWS Key Pair //
aws_key_name = "sai-key.pem"
