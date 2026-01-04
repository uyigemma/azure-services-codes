variable "display_name" {
  default = "serv_prin"
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "kvt" {
  name = "testing"

}

variable "location" {
  default = "canadacentral"
  
}