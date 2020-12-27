terraform {
  backend "remote" {
    organization = "kpanic9-corp"

    workspaces {
      name = "azure-ops-cli-run"
    }
  }

  required_providers {
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = "~> 2.12"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "${var.name}-resource-group"
  location = var.region
}

# provision vnet
# module "vnet" {
#   source         = "./vnet"
#   name           = var.name
#   cidr           = "10.0.0.0/16"
#   resource_group = azurerm_resource_group.this.name
#   private_subnets = {
#     private-1 = "10.0.1.0/24"
#     aks       = "10.0.2.0/24"
#   }
# }

# deploy AKS cluster
# module "aks" {
#   source              = "./aks"
#   name                = var.name
#   resource_group_name = azurerm_resource_group.this.name
#   aks_version         = "1.17.11"
#   default_node_pool = {
#     node_count = 1
#     vm_size    = "Standard_B2s"
#   }
#   pod_cni        = "azure"
#   network_policy = "calico"
#   subnet_id      = module.vnet.private_subnets["aks"]
#   whitelist_ips  = var.whitelist_ips

#   # other node pools
#   # node_pools = { 
#   #   default = {
#   #     vm_size = "Standard_B1s"
#   #     node_count = 1
#   #   }
#   # }
# }

# provision storage account and backup policies
# module "storage" {
#   source         = "./storage"
#   name           = "${var.name}tns"
#   resource_group = azurerm_resource_group.this.name
# }

# provision file shares
# module "file_share" {
#   source               = "./file-share"
#   name                 = var.name
#   resource_group       = azurerm_resource_group.this.name
#   storage_account_name = module.storage.storage_account_name
# }

# deploy a vm
# module "app_vm" {
#   source              = "./vm"
#   name                = "app"
#   resource_group_name = azurerm_resource_group.this.name
#   instance_type       = "Standard_B1ls"
#   subnet_id           = module.vnet.private_subnets["private-1"]
#   admin_user          = "appadmin"
#   admin_password      = var.admin_password
#   nsg_rules           = var.app_vm_nsg_rules
# }
