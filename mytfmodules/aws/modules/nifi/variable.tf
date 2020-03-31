variable "instance_count" {
  type = map(string)

  default = {
    "rest"            = 1
    "connect"         = 1
    "ksql"            = 1
    "schema"          = 1
    "control_center"  = 1
    "broker"          = 3
    "zookeeper"       = 3
    "nifi"            = 3
    "nifi_registry"   = 1
  }
}

variable "instance_prefix" {
  default     = "prod"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  default = "ami-00aa0a1b208ece144"
}


variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = true
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}


variable "instance_type" {
  description = "The type of instance to start"
  default = "m5.8xlarge"
}

variable "nifi_registry_instance_type" {
  description = "The type of instance to start"
  default = "t3.xlarge"
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = "kafka-prod"
}


variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default = "subnet-03938d9a45bdc3975"
}

variable "secondary_subnet" {
  description = "The VPC Subnet ID to launch in"
  default = "subnet-0d8b2d20a72c4d085"
}

variable "vpc_id" {
  description = "The VPC Subnet ID to launch in"
  default = "vpc-05b4f1d3e3f9cffbf"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "root_volume_type" {
  description = "Volume type for root"
  default = "gp2"
}

variable "root_volume_size" {
  description = "Volume size for root"
  default = 100
}



