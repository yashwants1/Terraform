
variable "sql_database_name" {
  description = "The name of the SQL database."
  type        = string
}

# variable "sql_server_id" {
#   description = "The ID of the SQL server where the database will be created."
#   type        = string
# }


variable "sql_Server" {
  description = "sql server"
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the SQL Server will be created."
  type        = string
}
