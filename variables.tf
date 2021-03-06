variable "name" {
  description = "Deployment name"
  type        = string
}

variable "region" {
  description = "Azure region"
  type        = string
}

variable "admin_password" {}
variable "app_vm_nsg_rules" {}

variable "whitelist_ips" {
  description = "Public IP address of user"
  type        = list(string)
}
