resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = var.vnet_resource_group_name
  address_space       = var.vnet_address_cidr

  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_virtual_network.virtual_network.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.subnet_address_prefix

}

resource "azurerm_network_security_group" "subnet_nsg" {
  location            = var.vnet_location
  name                = "${var.subnet_name}-nsg"
  resource_group_name = var.vnet_resource_group_name
}

resource "azurerm_network_security_rule" "network_sec_rules" {
  count = length(var.network_sec_rules) > 0 ? length(var.network_sec_rules) : 0

  name                                       = lookup(var.network_sec_rules[count.index], "name", "default_rule_name")
  priority                                   = lookup(var.network_sec_rules[count.index], "priority")
  direction                                  = lookup(var.network_sec_rules[count.index], "direction", "Any")
  access                                     = lookup(var.network_sec_rules[count.index], "access", "Allow")
  protocol                                   = lookup(var.network_sec_rules[count.index], "protocol", "*")
  source_port_ranges                         = split(",", replace(lookup(var.network_sec_rules[count.index], "source_port_range", "*"), "*", "0-65535"))
  destination_port_ranges                    = split(",", replace(lookup(var.network_sec_rules[count.index], "destination_port_range", "*"), "*", "0-65535"))
  source_address_prefix                      = lookup(var.network_sec_rules[count.index], "source_application_security_group_ids", null) == null && lookup(var.network_sec_rules[count.index], "source_address_prefixes", null) == null ? lookup(var.network_sec_rules[count.index], "source_address_prefix", "*") : null
  destination_address_prefix                 = lookup(var.network_sec_rules[count.index], "destination_application_security_group_ids", null) == null && lookup(var.network_sec_rules[count.index], "destination_address_prefixes", null) == null ? lookup(var.network_sec_rules[count.index], "destination_address_prefix", "*") : null
  description                                = lookup(var.network_sec_rules[count.index], "description", "Security rule for ${lookup(var.network_sec_rules[count.index], "name", "default_rule_name")}")
  resource_group_name                        = var.vnet_resource_group_name
  network_security_group_name                = azurerm_network_security_group.subnet_nsg.name
  source_application_security_group_ids      = lookup(var.network_sec_rules[count.index], "source_application_security_group_ids", null)
  destination_application_security_group_ids = lookup(var.network_sec_rules[count.index], "destination_application_security_group_ids", null)

  depends_on = [azurerm_network_security_group.subnet_nsg]
}
