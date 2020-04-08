


######## LOCALS Section ########
locals {
  //## Including region.hcl file from the previous directory to make variables.
  region_vars             = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  // Creating a variable and assigning value
  region                  = local.region_vars.locals.aws_region
  # azs                     = local.region_vars.locals.aws_azs

  //## Including env.hcl file from the previous directory to make variables.
  environment_vars        = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  // Creating a variable and assigning value
  env                     = local.environment_vars.locals.environment

// Creating more variable and assigning value. So that we can pass it to the tf modules.
  # kafka_service_name          = "kafka"
  broker_service_name         = "kafka_broker"
  zookeeper_service_name      = "zookeeper"
  kafka_schema_registry_name  = "schema_registry"
  kafka_connect_name          = "kafka_connect"
  kafka_ksql_name             = "ksql"
  kafka_restproxy_name        = "kafka_rest"
  kafka_control_center_name   = "control_center"
}


######## REPOSITORY Section ########
terraform {
  //Specify your repository, branch/tag name and tfmodules path.
  source = "git::git@gitlab.com:slower-west/ucsd/tfmodules.git//aws/modules/kafka?ref=develop"
}



######## INPUT Section ########
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above.
# In the blow inputs we just putting variables and their values.
inputs = {
  # Creating varaiable and getting value form the above local section.
  region       = local.region
  # azs          = local.azs
  environment  = local.env
  
  # Specify your existing key pair name
  aws_key_name = "sai-key"

// ======= Common variable =======
  ## [ Specify your existing VPC and Subnet id from aws env ]
  vpc_id                        = "vpc-f221328b"
  subnet_id                     = "subnet-6436763e"
  associate_public_ip_address   = "true"

  ## [ Root Volume type ]
  root_volume_type = "gp2"
  delete_on_termination = true
  # root_volume_size = 10

  //## [ EBS Volume ]
  # ebs_volume_type = "gp2"
  # ebs_volume_type = "st1"
  # ebs_volume_size = 8
  
  ## Kafka Variables //
  kafka_image          = "ami-0ce21b51cb31a48b8"  # Amazon Linux 2 AMI OR RHEL
  # kafka_instance_type  = "t2.medium"
  kafka_instance_type  = "m5.large"
  
// ==== Broker/Kafka =====
  ## [ Number of instances to launch ]
  broker_instance_count   = 2
   ## [ Root Volume size ]
  broker_root_volume_size = 8
  ## [ EBS Volume type and size ]
  broker_ebs_volume_type  = "gp2"
  broker_ebs_volume_size  = 8
  ## [ Service name for sg,volume,ec2,nw tag] 
  broker_service_name     = local.broker_service_name

// ==== Zookeeper ==== //
  ## [ Number of instances to launch ]
  zookeeper_instance_count   = 2
  ## [ Root Volume size ]
  zookeeper_root_volume_size = 8
  ## [ EBS Volume type and size ]
  zookeeper_ebs_volume_type  = "gp2"
  zookeeper_ebs_volume_size  = 8
  ## [ Service name for sg,volume,ec2,nw tag]
  zookeeper_service_name     = local.zookeeper_service_name

// ==== kafka Schema Registry =====
  kafka_schema_registry_instance_count    = 1
  kafka_schema_registry_root_volume_size  = 8
  kafka_schema_registry_ebs_volume_type   = "gp2"
  kafka_schema_registry_ebs_volume_size   = 8
  kafka_schema_registry_name              = local.kafka_schema_registry_name

// ==== kafka Connect =====
  kafka_connect_instance_count   = 1
  kafka_connect_root_volume_size = 8
  kafka_connect_ebs_volume_type  = "gp2"
  kafka_connect_ebs_volume_size  = 8
  kafka_connect_name             = local.kafka_connect_name

// ==== Kafka KSQL =====
  kafka_ksql_instance_count   = 1
  kafka_ksql_root_volume_size = 8
  kafka_ksql_ebs_volume_type  = "gp2"
  kafka_ksql_ebs_volume_size  = 8
  kafka_ksql_name             = local.kafka_ksql_name

// ==== kafka Restproxy =====
  kafka_restproxy_instance_count   = 1
  kafka_restproxy_root_volume_size = 8
  kafka_restproxy_ebs_volume_type  = "gp2"
  kafka_restproxy_ebs_volume_size  = 8
  kafka_restproxy_name             = local.kafka_restproxy_name

// ==== kafka Control Center =====
  kafka_control_center_instance_count   = 1
  kafka_control_center_root_volume_size = 8
  kafka_control_center_ebs_volume_type  = "gp2"
  kafka_control_center_ebs_volume_size  = 8
  kafka_control_center_name             = local.kafka_control_center_name
}
