resource "azurerm_policy_set_definition" "name" {
  for_each     = var.policy_sets
  name         = each.key
  policy_type  = "Custom"
  display_name = each.key

  dynamic "policy_definition_reference" {
    for_each = each.value.policy_definition_references
    content {
      policy_definition_id = var.policy_definitions[policy_definition_reference.value].id
    }
  }
}