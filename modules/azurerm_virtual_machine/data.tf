data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "Public_IP" {
  name                = var.pip
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault
  resource_group_name = "ak-rg"
}

data "azurerm_key_vault_secret" "username" {
  name         = var.username
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "secret" {
  name         = var.secret
  key_vault_id = data.azurerm_key_vault.key_vault.id
}