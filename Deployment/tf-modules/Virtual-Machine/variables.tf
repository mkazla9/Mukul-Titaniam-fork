variable "nic_name" {
  type = string
  description = "Name of the network interface to associate with VM"
}

variable "rg_name" {
    type = string
    description = "The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created."
}

variable "rg_location" {
  type = string
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
}

variable "tags" {
  type        = map(string)
  description = "Map of tags that would be associates with resource"
}

variable "subnet_id" {
  type = string
  description = "Subnet id to associate with VM"
}

variable "vm_name" {
  type = string
  description = "Name of the virtual machine"
}

variable "custom_data" {
  type = string
  description = "Custom data to install docker"
}
