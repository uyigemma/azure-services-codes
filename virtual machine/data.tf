data "azurerm_key_vault_secret" "sec01" {
  name         = "username01"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "sec02" {
  name         = "password01"
  key_vault_id = data.azurerm_key_vault.existing.id
}
