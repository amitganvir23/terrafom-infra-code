provider "aws" {
  region = var.region
}

## creating New VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
	Name = "${var.environment}-terra-amit-vpc"
	}
}
