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
    key    = "aws-vm-provisioners/terraform.tfstate"
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

# Configura o acesso ao state remoto para obter dados de recursos provisionados e utilizar nos arquivos de configuração
# Aponta para o state utilizado na criação da '../aws-network/main.tf/#/backend' vamos associar a elementos definidos lá
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "wedson-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

