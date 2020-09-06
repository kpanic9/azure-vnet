output "subnets" {
  value = { for i in keys(var.subnets) : i => azurerm_subnet.this[i].id }
}

