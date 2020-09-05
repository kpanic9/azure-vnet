provider "azurerm" {
  version = "~> 2.20.0"
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "${var.name}-resource-group"
  location = var.region
}

# provision vnet
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

# provision storage account and backup policies
module "storage" {
  source         = "./storage"
  name           = "${var.name}tns"
  resource_group = azurerm_resource_group.this.name
}

# provision file shares
module "file_share" {
  source               = "./file-share"
  name                 = var.name
  resource_group       = azurerm_resource_group.this.name
  storage_account_name = module.storage.storage_account_name
}

