provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
}

resource "azurerm_resource_group" "rg-projectmonza" {
  name = "S2-RG-ProjectMonza"
  location = "westeurope"
}

resource "azurerm_mssql_server" "sql-projectmonza" {
  name                         = "sqlservermonzax679e6e9"
  resource_group_name          = azurerm_resource_group.rg-projectmonza.name
  location                     = azurerm_resource_group.rg-projectmonza.location
  version                      = "12.0"
  administrator_login          = "admindba"
  administrator_login_password = "ABCabc123.42"
}

resource "azurerm_sql_database" "dba-projectmonza" {
  name                = "dba42"
  resource_group_name = azurerm_resource_group.rg-projectmonza.name
  location            = azurerm_resource_group.rg-projectmonza.location
  server_name         = azurerm_mssql_server.sql-projectmonza.name
}

# Create FW rule to allow access from own IP address to the SQL Instance
resource "azurerm_sql_firewall_rule" "fw1-projectmonza" {
  name                = "FirewallRule1"
  resource_group_name = azurerm_resource_group.rg-projectmonza.name
  server_name         = azurerm_mssql_server.sql-projectmonza.name
  start_ip_address    = "91.205.194.1"
  end_ip_address      = "91.205.194.1"
}

# Create FW rule to allow access from internal Azure services to the SQL Instance
resource "azurerm_sql_firewall_rule" "fw2-projectmonza" {
  name                = "FirewallRule2"
  resource_group_name = azurerm_resource_group.rg-projectmonza.name
  server_name         = azurerm_mssql_server.sql-projectmonza.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
