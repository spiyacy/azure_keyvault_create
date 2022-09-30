variable "buildTags" {
    type    = map
    default = {
        "owner" = "user@company.com"
        "environment" = "Azure KeyVault for Hashicorp Vault"
        "provisioned_via_terraform" = "true"
    }
}

variable "rgName" {
    description = "Name of Azure Resource Group for Azure Keyvault"
}

variable "kvName" {
    description = "Name of Azure Key Vault Resource"
}

variable "location" {
    description = "Azure Region (eastus, eastus2, westus, etc)"
}

variable "azure_user_object_id" {
    type = string
    description = "User Object ID for required testing access"
}

variable "azure_application_object_id" {
    type = string
    description = "App Registration Object ID for required testing access"
}
