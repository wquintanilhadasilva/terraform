terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.59.0"
    }
  }

  /*Configura o backend */
  backend "s3" {
    bucket = "wedson-remote-state"
    key    = "commands/terraform.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      owner      = "wedson"
      managed-by = "terraform"
    }
  }
}