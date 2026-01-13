variable "azurerm_virtual_network" {
     type        = string
     default = "CLOUDFORGED-VNET"
}

variable "azurerm_resource_group" {
     type        = string
     default = "cloudforged-RG"
}

variable "azurerm_windows_virtual_machine" {
     type        = string
     default = "cloudforged-vm"
}

variable "azurerm_virtual_machine_extension" {
     type        = string
     default = "webex"
}
