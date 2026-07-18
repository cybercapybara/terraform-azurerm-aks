variable "name" {
  description = "Name of the managed Kubernetes cluster."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the cluster."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the cluster."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix used when creating the managed cluster's API server FQDN."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the control plane and node pool. Null uses the region default."
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "SLA tier of the cluster control plane. One of Free, Standard or Premium."
  type        = string
  default     = "Free"
}

variable "default_node_pool" {
  description = "Configuration of the default (system) node pool."
  type = object({
    name                 = optional(string, "default")
    vm_size              = optional(string, "Standard_D2s_v5")
    node_count           = optional(number, 2)
    auto_scaling_enabled = optional(bool, false)
    min_count            = optional(number, null)
    max_count            = optional(number, null)
    vnet_subnet_id       = optional(string, null)
  })
  default = {}
}

variable "network_plugin" {
  description = "Network plugin used by the cluster. One of azure, kubenet or none."
  type        = string
  default     = "azure"
}

variable "tags" {
  description = "Map of tags applied to the cluster."
  type        = map(string)
  default     = {}
}
