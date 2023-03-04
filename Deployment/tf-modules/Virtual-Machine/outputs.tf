output "nic_id" {
  value = azurerm_network_interface.network_interface.id
}

output "private_ip_address" {
  value = azurerm_linux_virtual_machine.example.private_ip_address
}
