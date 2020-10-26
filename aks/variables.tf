variable "name" {
  description = "AKS cluster name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "aks_version" {
  description = "Kubernestes version"
}

variable "default_node_pool" {
  description = "AKS cluster default node pool config"
  type = map(string)
}

variable "node_pools" {
  description = "AKS cluster additional worker node pools. Eg: pool-1 = { vm_size = size, node_count = 1 }"
  #type = map(string)
  default = {}
}

