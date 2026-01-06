terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "aaeff4b6-68b6-4218-9860-9671d25ba573"
}

resource "azurerm_resource_group" "rg" {
  name     = "ardit-interview-resources"
  location = "germanywestcentral"
}