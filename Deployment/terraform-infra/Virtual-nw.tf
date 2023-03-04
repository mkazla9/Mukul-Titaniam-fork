module "virtual-network" {
  source                   = "../tf-modules/Virtual-network-Subnets"
  vnet_address_cidr        = ["10.0.0.0/16"]
  vnet_location            = module.resource_group.resource_group_location
  vnet_name                = "titanium-vnet"
  vnet_resource_group_name = module.resource_group.resource_group_name
  subnet_address_prefix    = ["10.0.1.0/24"]
  subnet_name              = "titaniam-subnet1"
  sec_group_name = "titaniam-nsg"
  network_sec_rules = [local.http_rule, local.ssh_rule]

  tags = {
    CreatedBy = "Mukul"
  }
}