resource "azurerm_policy_definition" "name" {
  for_each     = var.custom_policies
  name         = jsondecode(file("${var.policy_config_path}${each.key}.json")).name
  policy_type  = "Custom"
  mode         = jsondecode(file("${var.policy_config_path}${each.key}.json")).properties.mode
  display_name = jsondecode(file("${var.policy_config_path}${each.key}.json")).properties.displayName
  metadata     = jsonencode(jsondecode(file("${var.policy_config_path}${each.key}.json")).properties.metadata)
  parameters   = jsonencode(jsondecode(file("${var.policy_config_path}${each.key}.json")).properties.parameters)
  policy_rule  = jsonencode(jsondecode(file("${var.policy_config_path}${each.key}.json")).properties.policyRule)
}