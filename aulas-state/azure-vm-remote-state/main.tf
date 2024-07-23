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
    resource_group_name  = "rg-terraform-state"          # ../remote/storage_account.tf/#/azurerm_resource_group.resource_group.name
    storage_account_name = "wedsonsilvaformstate"        # ../remote/storage_account.tf/#/azurerm_storage_account.storage_account.name
    container_name       = "remote-state"                # ../remote/storage_account.tf/#/azurerm_storage_container.container.name
    key                  = "azzure-vm/terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }

}

provider "azurerm" {
  features {}
}

# Configura o acesso ao state remoto para obter dados de recursos provisionados e utilizar nos arquivos de configuração
# Aponta para o mesmo state definido no backend acima
data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "wedsonsilvaformstate"
    container_name       = "remote-state"
    key                  = "azzure-vnet/terraform.tfstate"
  }
}