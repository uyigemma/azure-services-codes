resource "azurerm_resource_group" "cloud" {
  name     = "vm-001"
  location = "canadacentral"
}

# resource "azurerm_virtual_network" "example" {
#   name                = "example-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

resource "azurerm_subnet" "cloud" {
  name                 = "vm"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = var.azurerm_virtual_network
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "cloud" {
  name                = "vm-nic"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.cloud.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.cloud.id
  }
}

resource "azurerm_windows_virtual_machine" "cloud" {
  name                = var.azurerm_windows_virtual_machine
  resource_group_name = azurerm_resource_group.cloud.name
  location            = azurerm_resource_group.cloud.location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.sec01.value
  admin_password      = data.azurerm_key_vault_secret.sec02.value
  network_interface_ids = [
    azurerm_network_interface.cloud.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

#####################################
# Create Network Security Group and rules
resource "azurerm_network_security_group" "cloud" {
  name                = "vm-nsg"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
############################################

# Create public IPs
resource "azurerm_public_ip" "cloud" {
  name                = "vm-public-ip"
  location            = azurerm_resource_group.cloud.location
  resource_group_name = azurerm_resource_group.cloud.name
  allocation_method   = "Static"
}

###########################################

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "cloud" {
  network_interface_id      = azurerm_network_interface.cloud.id
  network_security_group_id = azurerm_network_security_group.cloud.id
}
 
 # Install IIS web server to the virtual machine
resource "azurerm_virtual_machine_extension" "web_server_install" {
  name                       = var.azurerm_virtual_machine_extension
  virtual_machine_id         = azurerm_windows_virtual_machine.cloud.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}
 