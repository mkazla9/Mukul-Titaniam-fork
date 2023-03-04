variable "vnet_name" {
  type        = string
  description = "The name of the virtual network. Changing this forces a new resource to be created."
}

variable "vnet_location" {
  type        = string
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network."
}

variable "vnet_address_cidr" {
  type        = list(string)
  description = "The address space that is used in the virtual network. You can supply more than one address space."
}

variable "subnet_address_prefix" {
  type        = list(string)
  description = "The address space that is used in the subnet. You can supply more than one address space."
}

variable "tags" {
  type        = map(string)
  description = "Map of tags that would be associates with resource"
}

variable "subnet_name" {
  type = string
  description = "Name of the subnet that would be created in virtual network"
}

variable "sec_group_name" {
  type = string
  description = "Name of the security group to be associated with vnet"
}

variable "network_sec_rules" {
  type        = any
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
  default     = []
}