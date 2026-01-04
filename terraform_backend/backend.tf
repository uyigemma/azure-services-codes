terraform {
  backend "azurerm" {
    resource_group_name  = "testing"
    storage_account_name = "cloudforged"
    container_name       = "terraform-backend"
    key                  = "network/terraformt.tfstate"
  }
}
 