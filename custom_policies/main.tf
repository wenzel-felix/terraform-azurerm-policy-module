locals {
  policy_definition_files = fileset(var.policy_config_path, "**/*.json")
  policy_definitions_list = [for definition_file in local.policy_definition_files : jsondecode(file("${var.policy_config_path}${definition_file}"))]
  policy_definitions_map  = { for definition in local.policy_definitions_list : definition.name => definition.properties }
}

resource "azurerm_policy_definition" "name" {
  for_each     = local.policy_definitions_map
  name         = each.key
  policy_type  = "Custom"
  mode         = each.value.mode
  display_name = each.value.displayName
  metadata     = jsonencode(each.value.metadata)
  parameters   = jsonencode(each.value.parameters)
  policy_rule  = jsonencode(each.value.policyRule)
}