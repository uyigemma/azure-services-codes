output "tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}

output "client_id" {
  value = azuread_application.app.client_id
}

output "client_secret" {
  value     = azuread_application_password.secret.value
  sensitive = true
}