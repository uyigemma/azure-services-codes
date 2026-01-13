data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "example" {
  name                = var.azurerm_virtual_network
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

}

#resource "azurerm_subnet" "subnet1" {
 # name                 = "subnet-1"
  #resource_group_name  = var.resource_group_name
  #virtual_network_name = var.azurerm_virtual_network
  #address_prefixes     = ["10.0.0.0/25"]
}
