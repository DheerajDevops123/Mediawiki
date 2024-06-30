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
  subscription_id = "${var.azure-subscription-id}"
  client_id       = "${var.azure-client-id}"
  client_secret   = "${var.azure-client-secret}"
  tenant_id       = "${var.azure-tenant-id}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.rgname}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnetname}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  address_space       = "${var.vnet_cidr_prefix}"
}

resource "azurerm_subnet" "snet" {
  name                 = "${var.snetname}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = "${var.subnet_cidr_prefix}"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsgname}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  // Add more rules as needed for your application
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.publicipname}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name                      = "${var.nicname}"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.nicconfigmname}"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  depends_on=[azurerm_network_interface.nic]

  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  name                  = "${var.vmname}"
  network_interface_ids = [azurerm_network_interface.linux-vm-nic.id]
  size                  = "${var.vm_size}"

  source_image_reference {
    offer     = "${var.vm_image_offer}"
    publisher = "${var.vm_image_publisher}"
    sku       = "${var.rhel_8_5_sku}"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = "${var.username}"
  admin_password = "${var.password}"

  disable_password_authentication = false

  tags = {
    application = "${var.app}"
  }
}


