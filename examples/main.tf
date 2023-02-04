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

resource "random_string" "example1" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_storage_account" "example1" {
  name                     = random_string.example1.result
  resource_group_name      = azurerm_resource_group.example1.name
  location                 = azurerm_resource_group.example1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_string" "example2" {
  length  = 10
  upper   = false
  special = false
}

resource "azurerm_storage_account" "example2" {
  name                     = random_string.example2.result
  resource_group_name      = azurerm_resource_group.example2.name
  location                 = azurerm_resource_group.example2.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "local_file" "assignment" {
  content  = local.assignment_file_content
  filename = "policy_assignments/assignments.json"
}

data "azurerm_client_config" "current" {}
