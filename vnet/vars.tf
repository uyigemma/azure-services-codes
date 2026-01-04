variable "resource_group_name" {
     type        = string
    default = "testing"
}

variable "location" {
     type        = string
    default = "canadacentral"
}

variable "azurerm_virtual_network" {
     type        = string
  default = "uv-net"
}

 variable "address_space" {
    type        = list(string)
    default = ["10.0.0.0/24"]
 }
