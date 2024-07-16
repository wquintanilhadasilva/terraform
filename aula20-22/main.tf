terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }

}

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      owner      = "wedson"
      managed-by = "terraform"
    }

  }

}
