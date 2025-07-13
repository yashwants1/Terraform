module "resource_group" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "rg-Ytodoapp"
  resource_group_location = "centralindia"
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../modules/azurerm_virtual_network"


  virtual_network_name     = "vnet-Ytodoapp"
  virtual_network_location = "centralindia"
  resource_group_name      = "rg-Ytodoapp"
  address_space            = ["10.0.0.0/16"]
}

module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"

  resource_group_name  = "rg-Ytodoapp"
  virtual_network_name = "vnet-Ytodoapp"
  subnet_name          = "frontend-subnet"
  address_prefixes     = ["10.0.1.0/24"]
}

module "backend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"

  resource_group_name  = "rg-Ytodoapp"
  virtual_network_name = "vnet-Ytodoapp"
  subnet_name          = "backend-subnet"
  address_prefixes     = ["10.0.2.0/24"]
}

module "public_ip_frontend" {
  source              = "../modules/azurerm_public_ip"
  public_ip_name      = "frontend_pip-Ytodoapp"
  resource_group_name = "rg-Ytodoapp"
  location            = "centralindia"
  allocation_method   = "Static"
}

module "frontend_vm" {
  depends_on = [module.frontend_subnet]
  source     = "../modules/azurerm_virtual_machine"

  resource_group_name = "rg-Ytodoapp"
  location            = "centralindia"
  vm_name             = "vm-frontend"
  vm_size             = "Standard_B1s"
  # admin_username      = "devopsadmin"
  # admin_password      = "P@ssw0rd1234!"
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-focal"
  image_sku           = "20_04-lts"
  image_version       = "latest"
  nic_name            = "nic-vm-frontend"
  subnet_name          = "frontend-subnet"
  pip    = "frontend_pip-Ytodoapp"
  virtual_network_name = "vnet-Ytodoapp"
  key_vault = "ak12vault"
  username = "vmuser"
  secret = "vmpassword"
}

# module "public_ip_backend" {
#   source              = "../modules/azurerm_public_ip"
#   public_ip_name      = "Backend_pip-Ytodoapp"
#   resource_group_name = "rg-Ytodoapp"
#   location            = "centralindia"
#   allocation_method   = "Static"
# }

# module "backend_vm" {
#   depends_on = [module.backend_subnet]
#   source     = "../modules/azurerm_virtual_machine"

#   resource_group_name = "rg-Ytodoapp"
#   location            = "centralindia"
#   vm_name             = "vm-backend"
#   vm_size             = "Standard_B1s"
#   admin_username      = "devopsadmin"
#   admin_password      = "P@ssw0rd1234!"
#   image_publisher     = "Canonical"
#   image_offer         = "0001-com-ubuntu-server-focal"
#   image_sku           = "20_04-lts"
#   image_version       = "latest"
#   nic_name            = "nic-vm-backend"
#   subnet_name          = "backend-subnet"
#   pip    = "backendend_pip-Ytodoapp"
#   virtual_network_name = "vnet-Ytodoapp"
# }

# module "sql_server" {
#   source                       = "../modules/azurerm_sql_server"
#   sql_server_name              = "ytodosqlserver007"
#   resource_group_name          = "rg-Ytodoapp"
#   location                     = "centralindia"
#   administrator_login          = "sqladmin"
#   administrator_login_password = "P@ssw0rd1234!"
# }

# module "sql_database" {
#   depends_on = [module.sql_server]
#   source     = "../modules/azurerm_sql_database"

#   sql_database_name = "ytododb"
#   sql_Server = "ytodosqlserver007"
#   resource_group_name          = "rg-Ytodoapp"
# }