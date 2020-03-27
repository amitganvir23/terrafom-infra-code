variable "vpc_cidr" {
   description = "Sring - Vpc cidrs. Will be mapped in individual env files"
}

variable "environment" {
   description = "The AWS region to deploy to (e.g. us-east-1)"
   type        = string
}

variable "region" {}
