# Variablen für den Code
# Änderung der Werte hier, werden dann in main genutzt


variable "resource_group_name" {
  description = "Name der Resource Group"
  type        = string
  default     = "ardit-interview-resources"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "germanywestcentral" # Frankfurt. Wichtig für Datenschutz und Geschwindigkeit
}

variable "vm_size" {
  description = "Größe der VM"
  type        = string
  default     = "Standard_B1s" # B1s ist kleine, kostengünstige Größe für Tests 
}

variable "admin_username" {
  description = "Admin Benutzername für die VM"
  type        = string
  default     = "adminuser"
}