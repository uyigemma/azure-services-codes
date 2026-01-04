resource "azurerm_key_vault" "test" {
  name                        = "kvtlesson"
  location                    = var.location
  resource_group_name         = data.azurerm_resource_group.kvt.name
  enabled_for_disk_encryption = true
  public_network_access_enabled = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "025ab53f-c42a-4171-a697-a2b98b91a740"

    key_permissions = [
      "Get"
    ]

    secret_permissions = ["Get", "List", "Set"]


  }
}