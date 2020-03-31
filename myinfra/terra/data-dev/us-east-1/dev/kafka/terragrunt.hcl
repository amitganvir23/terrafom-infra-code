locals {
  region_vars             = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region                  = local.region_vars.locals.aws_region
  azs                     = local.region_vars.locals.aws_azs

  environment_vars        = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env                     = local.environment_vars.locals.environment
  
  broker_service_name     = "kafka"
  zookeeper_service_name  = "zookeeper"

}

terraform {
  ### +++ Specify your repository and tfmodules
  source = "git::git@gitlab.com:glt-slower/glt-ucsd/mytfmodules.git//aws/modules/kafka?"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  region       = local.region
  # azs          = local.azs
  environment  = local.env
  aws_key_name = "sai-key"

  vpc_id                        = "vpc-07cab67d"
  subnet_id                     = "subnet-4c694a2b"
  associate_public_ip_address   = "false"

  # // Kafka Variables //
  kafka_image          = "ami-08bc77a2c7eb2b1da" 
  kafka_instance_type  = "t2.micro"
  kafka_instance_count = 1

  // Root Volume
  root_volume_type = "gp2"
  root_volume_size = 10

  // ## Zookeeper Var //
  zookeeper_instance_count = 1

  // kafka services name
  broker_service_name     = local.broker_service_name
  zookeeper_service_name  = local.zookeeper_service_name
}
