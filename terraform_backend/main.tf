resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_data_factory" "test" {
  name                = var.azurerm_data_factory
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}