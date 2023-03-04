module "load_balancer" {
  source         = "../tf-modules/Load-Balancer"
  lb_name        = "titaniam-lb"
  public_ip_name = "titaniam-ip"
  rg_location    = module.resource_group.resource_group_location
  rg_name        = module.resource_group.resource_group_name
  machine_ip     = module.virtual_machine.private_ip_address
  vnet_id        = module.virtual-network.virtual_network_id

  tags = {
    CreatedBy = "Mukul"
  }
}

# Adding NAT rule to access VM from LB using Azure DevOps
resource "azurerm_lb_nat_rule" "nat_rule" {
  resource_group_name            = module.resource_group.resource_group_name
  loadbalancer_id                = module.load_balancer.lb_id
  name                           = "sshAccess"
  protocol                       = "Tcp"
  frontend_port_start            = 22
  frontend_port_end              = 22
  backend_port                   = 22
  backend_address_pool_id        = module.load_balancer.backend_pool_id
  frontend_ip_configuration_name = "PublicIPAddress"
}
