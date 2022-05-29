terraform {

  required_version = ">= 1.0.10"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "hybridaccessltd"
    key    = "terraform/state"
    region = "eu-west-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}
