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
