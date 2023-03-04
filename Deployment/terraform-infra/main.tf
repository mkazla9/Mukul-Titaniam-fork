terraform {
  required_version = "=1.1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "virtual_machine" {
  source      = "../tf-modules/Virtual-Machine"
  nic_name    = "titaniam-nic"
  rg_location = module.resource_group.resource_group_location
  rg_name     = module.resource_group.resource_group_name
  subnet_id   = module.virtual-network.subnet_id
  custom_data = filebase64("${path.module}/cloud-config.txt")
  vm_name     = "titaniam-vm"
  tags = {
    CreatedBy = "Mukul"
  }
}

resource "azurerm_subnet_network_security_group_association" "associate_subnet" {
  subnet_id                 = module.virtual-network.subnet_id
  network_security_group_id = module.virtual-network.nsg_id
}
