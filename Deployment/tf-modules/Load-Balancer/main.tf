resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "load_balancer" {
  name                = var.lb_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "pool_address" {
  name                    = "${var.lb_name}-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool.id
  virtual_network_id      = var.vnet_id
  ip_address              = var.machine_ip
}

resource "azurerm_lb_rule" "lb_rule1" {
  loadbalancer_id                = azurerm_lb.load_balancer.id
  name                           = "${var.lb_name}-rule1"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool.id]
}