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

# Create FW rule to allow access from own IP address to the SQL Instance
resource "azurerm_sql_firewall_rule" "projectmonza1" {
  name                = "FirewallRule1"
  resource_group_name = azurerm_resource_group.projectmonza.name
  server_name         = azurerm_mssql_server.projectmonza.name
  start_ip_address    = "91.205.194.1"
  end_ip_address      = "91.205.194.1"
}

# Create FW rule to allow access from internal Azure services to the SQL Instance
resource "azurerm_sql_firewall_rule" "projectmonza2" {
  name                = "FirewallRule2"
  resource_group_name = azurerm_resource_group.projectmonza.name
  server_name         = azurerm_mssql_server.projectmonza.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
