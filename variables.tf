variable "rgname"{
    type = string
    description = "used for naming resource group"
}

variable "location"{
    type = string
    description = "used for selecting location"
    default = "eastus"
}

variable "vnetname"{
    type = string
    description = "used for naming the virtual network"
}

variable "snetname"{
    type = string
    description = "used for naming the sub network"
}

variable "nsgname"{
    type = string
    description = "used for naming the network security group"
}

variable "publicipname"{
    type = string
    description = "used for naming the public ip"
}

variable "nicname"{
    type = string
    description = "used for naming the network interface"
}

variable "nicconfigmname"{
    type = string
    description = "used for naming the network interface ip configuration"
}

variable "vmname"{
    type = string
    description = "used for naming the virtual machine"
}

variable "vnet_cidr_prefix" {
  type = string
  description = "This variable defines address space for vnet"
}

variable "subnet_cidr_prefix" {
  type = string
  description = "This variable defines address space for subnetnet"
}

variable "linux_vm_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
}

variable "linux_vm_image_publisher" {
  type        = string
  description = "Virtual machine source image publisher"
  default     = "RedHat"
}

variable "linux_vm_image_offer" {
  type        = string
  description = "Virtual machine source image offer"
  default     = "RHEL"
}

variable "rhel_8_5_sku" {
  type        = string
  description = "SKU for RHEL 8.5"
  default     = "8_5"
}

variable "linux_admin_username" {
  type        = string
  description = "Username for Virtual Machine administrator account"
}

variable "app" {
  type        = string
  description = "Application name"
}

variable "azure-subscription-id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "azure-client-id" {
  type        = string
  description = "Azure Client ID"
}

variable "azure-client-secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant ID"
}

output "linux_vm_admin_password" {
  description = "Administrator password for the Virtual Machine"
  value       = random_password.linux-vm-password.result
  sensitive   = true
}