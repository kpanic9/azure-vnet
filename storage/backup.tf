resource "azurerm_recovery_services_vault" "this" {
  name                = "${var.name}-recovery-vault"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = "Standard"
  soft_delete_enabled = true
}

# VM backup policy
resource "azurerm_backup_policy_vm" "this" {
  name                = "${var.name}-vm-backup-policy"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "00:00"
  }

  retention_daily {
    count = 5
  }
}
