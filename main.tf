provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
}

resource "azurerm_resource_group" "projectmonza" {
  name = "S2-RG-ProjectMonza"
  location = "westeurope"
}
