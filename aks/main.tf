data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  dns_prefix          = "${var.name}-aks"

  # TODO: Secure API server
  private_cluster_enabled         = false
  api_server_authorized_ip_ranges = var.whitelist_ips

  default_node_pool {
    name           = "${var.name}default"
    node_count     = var.default_node_pool.node_count
    vm_size        = var.default_node_pool.vm_size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  dynamic "network_profile" {
    for_each = var.pod_cni == "azure" ? { config = true } : {}
    content {
      network_plugin     = "azure"
      load_balancer_sku  = "standard"
      outbound_type      = "userDefinedRouting"
      network_policy     = var.network_policy
      service_cidr       = var.service_cidr
      dns_service_ip     = var.kube_dns_ip
      docker_bridge_cidr = var.docker_bridge_cidr
    }
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled = false
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each              = var.node_pools
  name                  = "${var.name}${each.key}"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  vnet_subnet_id        = var.subnet_id
}
