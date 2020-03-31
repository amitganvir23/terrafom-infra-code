### Configure the backend
terraform {
  backend "s3" {
    bucket  = "kafka-infra"
    key     = "Terraform/backend/prod/nifi-ec2/terraform.tfstate"
    region  = "us-west-2"
  }
}

