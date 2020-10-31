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
  type        = string
}

variable "default_node_pool" {
  description = "AKS cluster default node pool config"
  type        = map(string)
}

variable "node_pools" {
  description = "AKS cluster additional worker node pools. Eg: pool-1 = { vm_size = size, node_count = 1 }"
  type = map(object({
    vm_size    = string,
    node_count = number
  }))
  default = {}
}

variable "pod_cni" {
  description = "Kubernetes cluster pod networking plugin"
  type        = string
  default     = "kubenet"

  validation {
    condition     = can(regex("kubenet|azure", var.pod_cni))
    error_message = "AKS supports only kubenet and azure pod network plugins."
  }
}

variable "subnet_id" {
  description = "Azure subnet id to create the AKS cluster"
  type        = string
  default     = null
}

# This range should not be used by any network element on or connected to this virtual network
variable "service_cidr" {
  description = "Kubernetes service cidr"
  type        = string
  default     = "172.16.0.0/16"
}

variable "kube_dns_ip" {
  description = "IP address of the kube dns service, should be with in the service cidr"
  type        = string
  default     = "172.16.0.10"
}

variable "docker_bridge_cidr" {
  description = "Docker installation on workers bridge network CIDR. Required, used for docker builds."
  type        = string
  default     = "192.168.1.1/24"
}

