terraform {

  required_version = ">= 1.0.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  backend "s3" {
    bucket = "hybridaccessltd"
    key    = "terraform/state/tfstate.tf"
    region = "eu-west-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}
