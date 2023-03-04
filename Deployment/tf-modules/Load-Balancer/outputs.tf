output "lb_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "lb_id" {
  value = azurerm_lb.load_balancer.id
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.pool.id
}
