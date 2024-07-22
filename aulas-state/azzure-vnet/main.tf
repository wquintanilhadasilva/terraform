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
    resource_group_name  = "rg-terraform-state"            # ../remote/storage_account.tf/#/azurerm_resource_group.resource_group.name
    storage_account_name = "wedsonsilvaformstate"          # ../remote/storage_account.tf/#/azurerm_storage_account.storage_account.name
    container_name       = "remote-state"                  # ../remote/storage_account.tf/#/azurerm_storage_container.container.name
    key                  = "azzure-vnet/terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }

}

provider "azurerm" {
  features {}
}