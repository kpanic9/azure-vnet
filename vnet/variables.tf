variable "name" {
  description = "vNet name"
  type        = string
}

variable "cidr" {
  description = "IP address block for vNet"
  type        = string
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
}

variable "subnets" {
  description = "Map of subnet names to subnet cidr"
  type        = map(string)
}



