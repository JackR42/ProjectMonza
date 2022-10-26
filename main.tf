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

resource "azurerm_mssql_server" "projectmonza" {
  name                         = "sqlservermonzax679e6e9"
  resource_group_name          = azurerm_resource_group.projectmonza.name
  location                     = azurerm_resource_group.projectmonza.location
  version                      = "12.0"
  administrator_login          = "admindba"
  administrator_login_password = "ABCabc123.42"
}

resource "azurerm_sql_database" "projectmonza" {
  name                = "dba42"
  resource_group_name = azurerm_resource_group.projectmonza.name
  location            = azurerm_resource_group.projectmonza.location
  server_name         = azurerm_mssql_server.projectmonza.name
}
