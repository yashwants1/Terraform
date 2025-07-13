
data "azurerm_mssql_server" "mssql_server" {
  name                = var.sql_Server
  resource_group_name = var.resource_group_name
}

resource "azurerm_mssql_database" "sql_database" {
  name         = var.sql_database_name
  server_id    = data.azurerm_mssql_server.mssql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
}