output "public_ip_address" {
  description = "Die öffentliche IP-Adresse der VM"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "ssh_connection_string" {
  description = "Befehl zum Verbinden"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.public_ip.ip_address}"
}