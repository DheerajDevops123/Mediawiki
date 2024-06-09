# Azure Virtual Machine resource
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  client_id      = "3c4f8158-b34f-4bc3-bf2a-82e13a1ce0fa"
  tenant_id      = "6b5f16f1-2045-4f8d-9294-2c6b3b0dda5b"
  client_secret   = "MRc8Q~dS-aeXnZ2k3LW0qDzhLTKVy~IjcallkbcM"
  subscription_id = "8b6aedac-849e-4552-9042-f0d064f7d434"
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "saidheerajrg"
  location = "East US"
}

# Azure Virtual Machine resource
resource "azurerm_virtual_machine" "example" {
  name                  = "example-vm"
  location              = var.location.example
  resource_group_name   = var.resource_group_name.example
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8_2"
    version   = "latest"
  }

  # Add OS disk configuration block
  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"  # Change to your desired disk type
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
  }

  # Define SSH public key directly under the virtual machine resource
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  tags = {
    environment = "production"
  }
}
