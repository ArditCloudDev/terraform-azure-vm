# Hauptkonfiguration

# 1. Terraform & Provider Konfiguration, ich möchte hier Azure (azurerm) steuern
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}


# 2. Subscription_id, wer zahlt die "VM" in diesem Fall
provider "azurerm" {
  features {}
# nachgebessert, Subscription_id gelöscht. Terraform nutzt die aktive CLI-Session (az login).
}

# 3. Resource Group (Container)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


# 4. Virtual Network (VNet) aufsetzen. (Stadtgebiet)
resource "azurerm_virtual_network" "vnet" {
  name                = "interview-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet (Stadteil / Viertel)
resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP (Adresse im Telefonbuch / Briefkasten)
resource "azurerm_public_ip" "public_ip" {
  name                = "vm-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interface (NIC)
resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic" # interne IP, deshalb egal
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Security (NSG)
resource "azurerm_network_security_group" "nsg" {
  name                = "vm-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound" # Eingehender Verkehr
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22" # Standard SSH Port
    source_address_prefix      = "*" 
    # "*" = "Allow Any". Für die Demo okay, damit ich sofort Zugriff habe.
    # In Realität würde hier NUR die eigene Firmen-IP eingetragen werden. 
    destination_address_prefix = "*"
  }
}

# Verknüofung NSG <-> NIC
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


# Virtuelle Linux Maschine (Haus)
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "interview-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

# SSH-Key Authentifizierung (Sicherer als Passwort)
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(pathexpand(var.ssh_public_key_path)) 
  }

# Festplatte
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

# Betriebssystem (Image)
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    # "-arm64" angehangen, damit es auf B2ps_v2 läuft
    sku       = "22_04-lts-arm64"
    version   = "latest"
  }
}