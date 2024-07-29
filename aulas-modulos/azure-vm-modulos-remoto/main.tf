terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.113.0"
    }
  }

  /*Configura o backend */
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"                          # ../remote/storage_account.tf/#/azurerm_resource_group.resource_group.name
    storage_account_name = "wedsonsilvaformstate"                        # ../remote/storage_account.tf/#/azurerm_storage_account.storage_account.name
    container_name       = "remote-state"                                # ../remote/storage_account.tf/#/azurerm_storage_container.container.name
    key                  = "azzure-vm-modulos-remotos/terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }

}

provider "azurerm" {
  features {}
}

module "network" {
  source  = "Azure/network/azurerm"
  version = "5.2.0"

  resource_group_name     = azurerm_resource_group.resource_group.name
  resource_group_location = var.location
  use_for_each            = true
  subnet_names            = ["subnet-${var.environment}"]
  tags                    = local.common_tags
  vnet_name               = "vnet-${var.environment}"

}