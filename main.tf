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

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "rg" {
    name     = var.rgName
    location = var.location

    tags = var.buildTags
}

# Create Key Vault resource
resource "azurerm_key_vault" "kv_resource" {
  name                        = var.kvName
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = false
  sku_name = "premium"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
  }

  tags = var.buildTags
}



# Apply a specific user access policy with a list of objectIDs
resource "azurerm_key_vault_access_policy" "user_policy" {
  key_vault_id  = azurerm_key_vault.kv_resource.id
  tenant_id     = data.azurerm_client_config.current.tenant_id
  object_id     = var.azure_user_object_id

  certificate_permissions = [
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "SetIssuers",
      "Update",
    ]

    key_permissions = [
      "Backup",
      "Create",
      "Decrypt",
      "Delete",
      "Encrypt",
      "Get",
      "Import",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Sign",
      "UnwrapKey",
      "Update",
      "Verify",
      "WrapKey",
    ]

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]
}

# Apply a specific application access policy with a list of object and application IDs
resource "azurerm_key_vault_access_policy" "application_policy" {
  key_vault_id  = azurerm_key_vault.kv_resource.id
  tenant_id     = data.azurerm_client_config.current.tenant_id
  object_id     =  var.azure_application_object_id

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]
}


# Generate random text for a unique ID
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Create Key
resource "azurerm_key_vault_secret" "example" {
  name         = "randompass"
  value        = random_password.password.result
  key_vault_id = resource.azurerm_key_vault.kv_resource.id
}

# Create Key2
resource "azurerm_key_vault_secret" "example2" {
  name         = "randompass2"
  value        = "mypassword"
  key_vault_id = resource.azurerm_key_vault.kv_resource.id
}

#comment update