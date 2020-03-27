locals {
  ##--Region
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region   = local.region_vars.locals.aws_region
       ##OR
  #region = "us-east-1"
  ##--

  ##--
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
  env2 = "dev2"
  ##--  
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@gitlab.com:glt-slower/ucsd/tfmodules.git//aws/modules/kafka?"
}

# Include all settings from the root terragrunt.hcl file
#include {
#  path = find_in_parent_folders()
#}

#include = {
#   path = "${find_in_parent_folders()}"
#}

 #required_inputs_files {
 #     "${get_terragrunt_dir()}/${find_in_parent_folders("region.hcl")}",
#}


# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  vpc_cidr    = "10.10.0.0/16"
  environment = local.env2
  #environment = local.environment_vars.locals.environment
  region = local.region
  #region = "us-weast-1"
  #aws_region = get_input("aws_region")
  #aws_region = "us-east-2"
  #region = "${local.aws_region}"
  
}

#inputs = merge(
#  local.account_vars.locals,
#  local.region_vars.locals,
#  local.environment_vars.locals,
#)