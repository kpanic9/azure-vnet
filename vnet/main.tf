data "azurerm_resource_group" "this" {
  name = var.resource_group
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.name}-vnet"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = [var.cidr]

  tags = {
    Name = "${var.name}-vnet"
  }
}

resource "azurerm_subnet" "this" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
}

