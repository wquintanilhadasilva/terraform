resource "azurerm_resource_group" "resource_group" {
  name     = "rg.vm"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-terraform"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  tags                = local.common_tags
}

resource "azurerm_network_interface" "network_interface" {
  name                = "nic_terraform"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "public-ip-terraform"
    subnet_id                     = data.terraform_remote_state.vnet.outputs.subnet_id # busca o valor no state do código que criou a network
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  tags = local.common_tags
}

resource "azurerm_network_interface_security_group_association" "nisga" {
  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = data.terraform_remote_state.vnet.outputs.security_group_id # busca o valor no state do código que criou a network
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-terraform"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "terraform"
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  admin_ssh_key {
    username   = "terraform"
    public_key = file("./azure-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(file("./docs/docker.sh"))

  tags = local.common_tags
}