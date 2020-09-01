provider "azurerm" {
  version = "=2.20.0"
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "${var.name}-resource-group"
  location = var.region
}

module "vnet" {
  source         = "./vnet"
  name           = var.name
  cidr           = "10.0.0.0/16"
  resource_group = azurerm_resource_group.this.name
  subnets = {
    public-1  = "10.0.0.0/24"
    private-1 = "10.0.1.0/24"
  }
}



