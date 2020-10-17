data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.name}-vm-nsg"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_network_security_rule" "this" {
  for_each                    = var.nsg_rules
  name                        = each.key
  priority                    = each.value[0]
  direction                   = each.value[1]
  access                      = each.value[2]
  protocol                    = each.value[3]
  source_port_range           = each.value[4]
  destination_port_range      = each.value[5]
  source_address_prefix       = each.value[6]
  destination_address_prefixes  = ["${azurerm_public_ip.this.ip_address}/32", "${azurerm_network_interface.this.private_ip_address}/32"]
  resource_group_name         = data.azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.this.name
}

resource "azurerm_public_ip" "this" {
  name                = "${var.name}-vm-public-ip"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "this" {
  name                = "${var.name}-vm-private-nic"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  ip_configuration {
    name                          = "${var.name}-vm-private-ip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_virtual_machine" "this" {
  name                  = "${var.name}-vm"
  location              = data.azurerm_resource_group.this.location
  resource_group_name   = data.azurerm_resource_group.this.name
  network_interface_ids = [azurerm_network_interface.this.id]
  vm_size               = var.instance_type

  # delete the OS and Data disk automatically when deleting the VM
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.name
    admin_username = var.admin_user
    admin_password = var.admin_password
    custom_data    = file("${path.module}/user-data.sh")
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}


