# IP Adresse wird im Statefile gespeichert und von dort ausgegeben

output "public_ip_address" {
  description = "Die öffentliche IP-Adresse der VM"
  value       = azurerm_public_ip.public_ip.ip_address
  # Rückgabe der IP-Adresse des Servers
}

output "ssh_connection_string" {
  description = "Befehl zum Verbinden"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.public_ip.ip_address}"
  # ssh + "admin username (var)" + @ + "IP des Servers"
  # kann perfekt kopiert und für den Zugang ins Terminal eingegeben werden.
}