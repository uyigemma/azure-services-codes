resource "azurerm_role_assignment" "sp_contributor_rg" {
  scope                =  data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.sp.object_id
}
 

 