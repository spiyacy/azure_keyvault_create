# Azure Key Vault

This Terraform configuration uses the [Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest) to provision an Azure Key Vault.

## Usage
---

|Variable   	|Description    	|
|---	|---	|
|buildTags|List of Tags for the Resource Group and Key Vault| 
|rgName|Name for Resource Group|  
|kvName|Name for Key Vault| 
|location|Azure Region|
|azure_user_object_id|User Object ID for required testing access|
|azure_application_object_id|App Registration Object ID for required testing access|

---
<br>

### Recommendation
- Create a <b><u>free</u></b> [Terraform Cloud](https://app.terraform.io/) account to manage the deployment of your Azure Key Vault statefile!!
  - Add the following into the <u>main.tf</u> <b>terraform { }</b> block
  ``` cloud {
    organization = "my_terraform_cloud_organization_name"

    workspaces {
      name = "my_workspace_name"
    }
  