provider "azurerm" {
  features {}
}

module "policy" {
  depends_on = [
    azurerm_resource_group.example1,
    azurerm_resource_group.example2,
    azurerm_storage_account.example1,
    azurerm_storage_account.example2
  ]
  source             = "../"
  policies           = var.policies
  policy_config_path = var.policy_config_path
  policy_sets        = var.policy_sets
}

resource "azurerm_resource_group" "example1" {
  name     = "example1"
  location = "West Europe"
}

resource "azurerm_resource_group" "example2" {
  name     = "example2"
  location = "West Europe"
}

resource "azurerm_storage_account" "example1" {
  name                     = "geantnamelllawdadad1"
  resource_group_name      = azurerm_resource_group.example1.name
  location                 = azurerm_resource_group.example1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_account" "example2" {
  name                     = "geantnamelllawdadad2"
  resource_group_name      = azurerm_resource_group.example2.name
  location                 = azurerm_resource_group.example2.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}