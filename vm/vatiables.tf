variable "name" {
  description = "vNet name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "instance_type" {
  description = "Azure instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to create the VM"
  type        = string
}

variable "admin_user" {
  description = "Administrator user name"
  type        = string
}

variable "admin_password" {
  description = "Administrator password"
  type        = string
}