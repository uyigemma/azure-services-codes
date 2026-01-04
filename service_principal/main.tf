
resource "azuread_application" "app" {
  display_name = var.display_name
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id
}

resource "azuread_application_password" "secret" {
  application_id    = azuread_application.app.id
  display_name      = var.display_name
  end_date_relative = "8760h" # 1 year
}

resource "azurerm_key_vault_secret" "sp_secret_in_kv" {
  name         = "my-tf-sp-client-secret"
  value  = azuread_application_password.secret.value
  key_vault_id = azurerm_key_vault.test.id
}