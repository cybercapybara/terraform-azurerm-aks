# terraform-azurerm-aks

Terraform module that manages an [Azure](https://azure.microsoft.com/)
Kubernetes Service (AKS) cluster. It provisions a cluster with a system node
pool, a system-assigned managed identity and the Azure CNI network plugin, and
exposes the API server FQDN and a sensitive kubeconfig output.

## Usage

```hcl
module "aks" {
  source = "github.com/moveeeax/terraform-azurerm-aks"

  name                = "prod-aks"
  resource_group_name = "prod-rg"
  location            = "eastus"
  dns_prefix          = "prodaks"

  default_node_pool = {
    name                 = "system"
    vm_size              = "Standard_D4s_v5"
    auto_scaling_enabled = true
    min_count            = 2
    max_count            = 5
  }

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

A runnable example lives in [`examples/basic`](examples/basic).

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.5   |
| azurerm   | >= 3.0   |

## Inputs

| Name                  | Description                                                       | Type          | Default    | Required |
|-----------------------|-------------------------------------------------------------------|---------------|------------|:--------:|
| `name`                | Name of the managed Kubernetes cluster.                           | `string`      | n/a        |   yes    |
| `resource_group_name` | Name of the resource group in which to create the cluster.        | `string`      | n/a        |   yes    |
| `location`            | Azure region in which to create the cluster.                      | `string`      | n/a        |   yes    |
| `dns_prefix`          | DNS prefix used for the cluster's API server FQDN.                | `string`      | n/a        |   yes    |
| `kubernetes_version`  | Kubernetes version. Null uses the region default.                 | `string`      | `null`     |    no    |
| `sku_tier`            | SLA tier of the control plane. One of Free, Standard or Premium.  | `string`      | `"Free"`   |    no    |
| `default_node_pool`   | Configuration of the default (system) node pool.                  | `object`      | `{}`       |    no    |
| `network_plugin`      | Network plugin used by the cluster.                               | `string`      | `"azure"`  |    no    |
| `tags`                | Map of tags applied to the cluster.                               | `map(string)` | `{}`       |    no    |

## Outputs

| Name                    | Description                                             |
|-------------------------|---------------------------------------------------------|
| `id`                    | ID of the managed Kubernetes cluster.                   |
| `name`                  | Name of the managed Kubernetes cluster.                 |
| `fqdn`                  | FQDN of the cluster's Kubernetes API server.            |
| `kube_config_raw`       | Raw kubeconfig for the cluster (sensitive).             |
| `identity_principal_id` | Principal ID of the cluster's managed identity.         |

## License

[MIT](LICENSE)
