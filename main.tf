terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "aaeff4b6-68b6-4218-9860-9671d25ba573"
}

resource "azurerm_resource_group" "rg" {
  name     = "ardit-interview-resources"
  location = "germanywestcentral"
}

# NETZWERK KONFIGURATION

# 2. Virtual Network (Das private Netzwerk)
resource "azurerm_virtual_network" "vnet" {
  name                = "interview-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 3. Subnet (Teilbereich für die VM)
resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}