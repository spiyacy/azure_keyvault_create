output "keyvault_info" {
  value = azurerm_key_vault.kv_resource
}

output "keyvaultID" {
  value = azurerm_key_vault.kv_resource.id
}
