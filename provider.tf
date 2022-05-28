terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "London"
}

# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}