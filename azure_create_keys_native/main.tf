# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azurerm_client_config" "current" {}

variable "keyvault_name" {}
variable "resourcegroup_name" {}


data "azurerm_key_vault" "example" {
  name                = var.keyvault_name
  resource_group_name = var.resourcegroup_name
}


# Generate random text for a unique ID
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Create Key
resource "azurerm_key_vault_secret" "example" {
  name         = "randompassvdata"
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.example.id
}


#comment update