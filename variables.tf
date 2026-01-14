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
  default     = "germanywestcentral" 
}

variable "vm_size" {
  description = "Größe der VM"
  type        = string
  default     = "Standard_B2ps_v2"  
}

variable "admin_username" {
  description = "Admin Benutzername für die VM"
  type        = string
  default     = "adminuser"
}

# Den Computerpfad für den SSH-Key ersetzen
variable "ssh_public_key_path" {
  description = "Pfad zum öffentlichen SSH-Key auf dem lokalen Rechner"
  type        = string
  # ~ ist Zeichen für Home-Verzeichnis also C:/User...
  default = "~/.ssh/id_rsa.pub"
}