
/*
   Variables for all modules
*/


// Generic
variable "region" {}
# variable "azs" {
#     default = []
# }

// Key pair //
variable "aws_key_name" {}


# // VPC
variable "vpc_id" {}
variable "subnet_id" {}
# variable "vpc_cidr" {}

// Genral variables //
variable "environment" {}



# // Kafka //
variable "kafka_image" {}
variable "kafka_instance_type" {}
variable "associate_public_ip_address" {}

// Root Volume
variable "root_volume_type" {
  default = "gp2"
}
# variable "root_volume_size" {
#   default = "8"
# }

# variable "ebs_volume_type" {
#   default = "gp2"
# }
# variable "ebs_volume_size" {
#   default = "8"
# }


#====================
// ==== Broker/Kafka =====
  variable "broker_instance_count" {}
  variable "broker_root_volume_size" {}
  variable "broker_ebs_volume_type" {}
  variable "broker_ebs_volume_size" {}
  variable "broker_service_name" {}

// ==== Zookeeper ==== //
  variable "zookeeper_instance_count" {}
  variable "zookeeper_root_volume_size" {}
  variable "zookeeper_ebs_volume_type" {}
  variable "zookeeper_ebs_volume_size" {}
  variable "zookeeper_service_name" {}

// ==== kafka Schema Registry =====
  variable "kafka_schema_registry_instance_count" {}
  variable "kafka_schema_registry_root_volume_size" {}
  variable "kafka_schema_registry_ebs_volume_type" {}
  variable "kafka_schema_registry_ebs_volume_size" {}
  variable "kafka_schema_registry_name" {}

// ==== kafka Connect =====
  variable "kafka_connect_instance_count" {}
  variable "kafka_connect_root_volume_size" {}
  variable "kafka_connect_ebs_volume_type" {}
  variable "kafka_connect_ebs_volume_size" {}
  variable "kafka_connect_name" {}

// ==== Kafka KSQL =====
  variable "kafka_ksql_instance_count" {}
  variable "kafka_ksql_root_volume_size" {}
  variable "kafka_ksql_ebs_volume_type" {}
  variable "kafka_ksql_ebs_volume_size" {}
  variable "kafka_ksql_name" {}

// ==== kafka Restproxy =====
  variable "kafka_restproxy_instance_count" {}
  variable "kafka_restproxy_root_volume_size" {}
  variable "kafka_restproxy_ebs_volume_type" {}
  variable "kafka_restproxy_ebs_volume_size" {}
  variable "kafka_restproxy_name" {}

// ==== kafka Control Center =====
  variable "kafka_control_center_instance_count" {}
  variable "kafka_control_center_root_volume_size" {}
  variable "kafka_control_center_ebs_volume_type" {}
  variable "kafka_control_center_ebs_volume_size" {}
  variable "kafka_control_center_name" {}
  