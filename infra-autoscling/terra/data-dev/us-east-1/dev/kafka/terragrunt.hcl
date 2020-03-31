locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region   = local.region_vars.locals.aws_region
  azs   = local.region_vars.locals.aws_azs

  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
  
  kafka_service_name = "kafka"
  zookeeper_service_name = "zookeeper"

}

terraform {
  ### +++ Specify your repository and tfmodules
  source = "git::git@gitlab.com:glt-slower/glt-ucsd/mytfmodules.git//aws/modules/kafka?"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  region       = local.region
  azs          = local.azs
  # environment  = "prod"
  environment  = local.env
  aws_key_name = "sai-key"

  ### +++ Put your VPC ID
  vpc_id                = "vpc-07cab67d"
  ### +++  Enter your public subnet with coma seprated.
  vpc_zone_identifier  = "subnet-4c694a2b,subnet-abe80da5"

  # // Kafka Variables //
  kafka_lc             = "${local.env}-${local.kafka_service_name}-lc"
  kafka_image          = "ami-08bc77a2c7eb2b1da" 
  kafka_instance_type  = "t2.micro"
  kafka_instance_count = 1
  kafka_cluster_size   = 0
  kafka_service_name   = local.kafka_service_name
  
  // Zookeeper Variables //
  zookeeper_lc             = "${local.env}-${local.zookeeper_service_name}-lc"
  zookeeper_image          = "ami-08bc77a2c7eb2b1da" 
  zookeeper_instance_type  = "t2.micro"
  zookeeper_instance_count = 1
  zookeeper_cluster_size   = 0
  zookeeper_service_name   = local.zookeeper_service_name

  // Route 53 //
  zone_name = "sai-test4.com"
  rec_name  = "kafka.sai.test4.com"
  
}

