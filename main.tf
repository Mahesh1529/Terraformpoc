terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg1" {
  name     = "example-resource-group"  
  location = "West US 2"  
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1-vnet"  
  address_space       = ["10.0.0.0/16"] 
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1-subnet"  # Update with your desired subnet name
  address_prefixes     = ["10.0.0.0/24"]  # Update with your desired subnet address range
  virtual_network_name = azurerm_virtual_network.vnet1.name
  resource_group_name  = azurerm_resource_group.rg1.name
}

resource "azurerm_network_interface" "net1" {
  name                = "net1-nic"  # Update with your desired network interface name
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

 ip_configuration {
    name                          = "mahesh-ip-config"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
 }


       
      


  

 
}
