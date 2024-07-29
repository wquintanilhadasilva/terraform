resource "azurerm_resource_group" "resource_group" {
  // Cria um resource group para cada location definida na variável 'location'
  for_each = var.location

  name     = "rg-${each.key}"
  location = each.value

  tags = local.common_tags
}


resource "azurerm_storage_account" "storage_account" {
  // Agora itera sobre cada resource group criado, um por item no map de location
  for_each = azurerm_resource_group.resource_group

  name                     = "wedsonsilva${each.key}"
  resource_group_name      = each.value.name
  location                 = each.value.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = local.common_tags
}

resource "azurerm_storage_container" "container" {
  // Agora itera sobre cada storage account criada e cria um container
  for_each = azurerm_storage_account.storage_account

  name                 = "imagens-${each.key}"
  storage_account_name = each.value.name
}