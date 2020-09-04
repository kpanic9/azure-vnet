data "azurerm_resource_group" "this" {
  name = var.resource_group
}

resource "azurerm_storage_account" "this" {
  name                     = "${var.name}-storage-account"
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}


