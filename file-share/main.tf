resource "azurerm_storage_share" "this" {
  name                 = var.name
  storage_account_name = var.storage_account_name
  quota                = 50
}

