data "azurerm_policy_definition" "name" {
  for_each     = var.builtIn_policies
  display_name = each.key
}
