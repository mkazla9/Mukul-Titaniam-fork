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

variable "public_ip_name" {
  type = string
  description = "Name of the public ip address to be associated with load balancer"
}

variable "lb_name" {
  type = string
  description = "Name of the load balancer to be associated"
}

variable "vnet_id" {
  type = string
  description = "ID of the vnet to be associated"
}

variable "machine_ip" {
  type = string
  description = "IP of the machine to associate with"
}
