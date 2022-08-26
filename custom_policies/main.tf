resource "azurerm_policy_definition" "name" {
  for_each     = var.custom_policies
  name         = each.key
  policy_type  = "Custom"
  mode         = lookup(each.value, "policy_type", "All")
  display_name = each.value["display_name"]
  metadata     = each.value["metadata"]
  parameters   = file("${var.policy_config_path}${each.key}/parameters.json")
  policy_rule  = file("${var.policy_config_path}${each.key}/policy_rule.json")
}