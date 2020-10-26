output "client_certificate" {
  description = "AKS cluster client certificate"
  value = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
}

output "kube_config" {
  description = "AKS cluster kube config"
  value = azurerm_kubernetes_cluster.this.kube_config_raw
}
