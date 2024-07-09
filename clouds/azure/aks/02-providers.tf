#================================================================================================
# Provider Configuration
#================================================================================================

terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  subscription_id = var.subscription_id
  # client_secret = Ensure $env:ARM_CLIENT_SECRET is set locally
}

provider "helm" {
  kubernetes {
    host                   = module.az_aks.aks_config[0].host
    client_certificate     = base64decode(module.az_aks.aks_config[0].client_certificate)
    client_key             = base64decode(module.az_aks.aks_config[0].client_key)
    cluster_ca_certificate = base64decode(module.az_aks.aks_config[0].cluster_ca_certificate)
  }
}
