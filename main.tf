locals {
  assignments = toset(flatten([
        for k, v in var.policies: [
            for assignment in v.assignments: {
                scope = assignment.scope
                unique_scope = element(split("/", assignment.scope), length(split("/", assignment.scope))-1)
                type = assignment.type
                policy = k
            }
        ]
    ]))
}

resource "null_resource" "name" {
    for_each = { 
        for unique in local.assignments: "${unique.type}-${unique.scope}-${unique.policy}" => unique
    }
    provisioner "local-exec" {
        command = "echo ${each.key}"
    }
}

resource "azurerm_policy_definition" "name" {
  for_each = var.policies
  name = each.key
  policy_type = "Custom"
  mode = lookup(each.value, "policy_type", "All")
  display_name = each.value["display_name"]
  metadata = each.value["metadata"]
  parameters = file("${var.policy_config_path}${each.key}/parameters.json")
  policy_rule = file("${var.policy_config_path}${each.key}/policy_rule.json")
}

resource "azurerm_subscription_policy_assignment" "name" {
    for_each = { 
        for unique in local.assignments: "${unique.type}-${unique.policy}-${unique.unique_scope}" => unique if unique.type == "SUB"
    }
    name = each.key
    policy_definition_id = azurerm_policy_definition.name[each.value.policy].id
    subscription_id = each.value.scope
}

resource "azurerm_management_group_policy_assignment" "name" {
    for_each = { 
        for unique in local.assignments: "${unique.type}-${unique.policy}-${unique.unique_scope}" => unique if unique.type == "MG"
    }
    name = each.key
    policy_definition_id = azurerm_policy_definition.name[each.value.policy].id
    management_group_id = each.value.scope
}

resource "azurerm_resource_group_policy_assignment" "name" {
    for_each = { 
        for unique in local.assignments: "${unique.type}-${unique.policy}-${unique.unique_scope}" => unique if unique.type == "RG"
    }
    name = each.key
    policy_definition_id = azurerm_policy_definition.name[each.value.policy].id
    resource_group_id = each.value.scope
}

resource "azurerm_resource_policy_assignment" "name" {
    for_each = { 
        for unique in local.assignments: "${unique.type}-${unique.policy}-${unique.unique_scope}" => unique if unique.type == "RES"
    }
    name = each.key
    policy_definition_id = azurerm_policy_definition.name[each.value.policy].id
    resource_id = each.value.scope
}