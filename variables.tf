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
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin Benutzername für die VM"
  type        = string
  default     = "adminuser"
}