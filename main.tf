provider "azurerm" {
  version = "=2.20.0"
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "${var.name}-resource-group"
  location = var.region
}
