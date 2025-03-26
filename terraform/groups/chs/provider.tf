terraform {
  backend "s3" {
    bucket = "development-eu-west-2.terraform-state.ch.gov.uk"
    key = "forgerock-data/development/chs.tfstate"
    region = "eu-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}
