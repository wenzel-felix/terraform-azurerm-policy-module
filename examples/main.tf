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
  source                    = "../"
  policy_definitions_path   = var.policy_definitions_path
  default_identity_location = var.default_identity_location
}

locals {
  location = "eastus"
}

resource "azurerm_resource_group" "example1" {
  name     = "example1"
  location = local.location
}

resource "azurerm_resource_group" "example2" {
  name     = "example2"
  location = local.location
}

resource "azurerm_storage_account" "example1" {
  name                     = "geantnamelllawdadad1"
  resource_group_name      = azurerm_resource_group.example1.name
  location                 = azurerm_resource_group.example1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "example2" {
  name                     = "geantnamelllawdadad2"
  resource_group_name      = azurerm_resource_group.example2.name
  location                 = azurerm_resource_group.example2.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}