locals {
  assignments_list = toset(flatten([
    for k, v in var.policies :
    lookup(v, "assignments", false) != false ?
    [
      for assignment in v.assignments : {
        scope          = assignment.scope
        unique_scope   = element(split("/", assignment.scope), length(split("/", assignment.scope)) - 1)
        type           = assignment.type
        use_identity   = assignment.use_identity
        policy         = k
        policy_acronym = join("", regexall("[A-Z]+", title(k)))
      }
    ] : []
  ]))
  exemptions_list = toset(flatten([
    for k, v in var.policies :
    lookup(v, "assignments", false) != false ?
    [
      for assignment in v.assignments :
      lookup(assignment, "exemptions", false) != false ?
      [
        for exemption in assignment.exemptions : {
          assignment_type         = assignment.type
          assignment_unique_scope = element(split("/", assignment.scope), length(split("/", assignment.scope)) - 1)
          scope                   = exemption.scope
          unique_scope            = element(split("/", exemption.scope), length(split("/", exemption.scope)) - 1)
          type                    = exemption.type
          policy                  = k
          policy_acronym          = join("", regexall("[A-Z]+", title(k)))
          exemption_category      = exemption.exemption_category
        }
      ] : []
    ] : []
    ]
  ))
}

############ Policy Assignments ############

resource "azurerm_management_group_policy_assignment" "name" {
  for_each = {
    for unique in local.assignments_list : "${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "MG"
  }
  name                 = each.key
  policy_definition_id = var.policy_definitions[each.value.policy].id
  management_group_id  = each.value.scope

  dynamic "identity" {
    for_each = each.value.use_identity == true ? [1] : []
    content {
      identity {
        type = "SystemAssigned"
      }
    }
  }
}

resource "azurerm_subscription_policy_assignment" "name" {
  for_each = {
    for unique in local.assignments_list : "${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "SUB"
  }
  name                 = each.key
  policy_definition_id = var.policy_definitions[each.value.policy].id
  subscription_id      = each.value.scope

  dynamic "identity" {
    for_each = each.value.use_identity == true ? [1] : []
    content {
      identity {
        type = "SystemAssigned"
      }
    }
  }
}

resource "azurerm_resource_group_policy_assignment" "name" {
  for_each = {
    for unique in local.assignments_list : "${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "RG"
  }
  name                 = each.key
  policy_definition_id = var.policy_definitions[each.value.policy].id
  resource_group_id    = each.value.scope

  dynamic "identity" {
    for_each = each.value.use_identity == true ? [1] : []
    content {
      identity {
        type = "SystemAssigned"
      }
    }
  }
}

resource "azurerm_resource_policy_assignment" "name" {
  for_each = {
    for unique in local.assignments_list : "${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "RES"
  }
  name                 = each.key
  policy_definition_id = var.policy_definitions[each.value.policy].id
  resource_id          = each.value.scope

  dynamic "identity" {
    for_each = each.value.use_identity == true ? [1] : []
    content {
      identity {
        type = "SystemAssigned"
      }
    }
  }
}

############ Policy Exemptions ############

resource "azurerm_resource_policy_exemption" "RG_assignment" {
  for_each = {
    for unique in local.exemptions_list : "${unique.exemption_category}-${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "RES" && unique.assignment_type == "RG"
  }
  name                 = each.key
  resource_id          = each.value.scope
  policy_assignment_id = azurerm_resource_group_policy_assignment.name["${each.value.assignment_type}-${each.value.policy_acronym}-${each.value.assignment_unique_scope}"].id
  exemption_category   = each.value.exemption_category
}

resource "azurerm_resource_policy_exemption" "SUB_assignment" {
  for_each = {
    for unique in local.exemptions_list : "${unique.exemption_category}-${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "RES" && unique.assignment_type == "SUB"
  }
  name                 = each.key
  resource_id          = each.value.scope
  policy_assignment_id = azurerm_subscription_policy_assignment.name["${each.value.assignment_type}-${each.value.policy_acronym}-${each.value.assignment_unique_scope}"].id
  exemption_category   = each.value.exemption_category
}

resource "azurerm_resource_policy_exemption" "MG_assignment" {
  for_each = {
    for unique in local.exemptions_list : "${unique.exemption_category}-${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "RES" && unique.assignment_type == "MG"
  }
  name                 = each.key
  resource_id          = each.value.scope
  policy_assignment_id = azurerm_management_group_policy_assignment.name["${each.value.assignment_type}-${each.value.policy_acronym}-${each.value.assignment_unique_scope}"].id
  exemption_category   = each.value.exemption_category
}

resource "azurerm_resource_group_policy_exemption" "SUB_assignment" {
  for_each = {
    for unique in local.exemptions_list : "${unique.exemption_category}-${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "RG" && unique.assignment_type == "SUB"
  }
  name                 = each.key
  resource_group_id    = each.value.scope
  policy_assignment_id = azurerm_subscription_policy_assignment.name["${each.value.assignment_type}-${each.value.policy_acronym}-${each.value.assignment_unique_scope}"].id
  exemption_category   = each.value.exemption_category
}

resource "azurerm_resource_group_policy_exemption" "MG_assignment" {
  for_each = {
    for unique in local.exemptions_list : "${unique.exemption_category}-${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "RG" && unique.assignment_type == "MG"
  }
  name                 = each.key
  resource_group_id    = each.value.scope
  policy_assignment_id = azurerm_management_group_policy_assignment.name["${each.value.assignment_type}-${each.value.policy_acronym}-${each.value.assignment_unique_scope}"].id
  exemption_category   = each.value.exemption_category
}

resource "azurerm_subscription_policy_exemption" "MG_assignment" {
  for_each = {
    for unique in local.exemptions_list : "${unique.exemption_category}-${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "SUB" && unique.assignment_type == "MG"
  }
  name                 = each.key
  subscription_id      = each.value.scope
  policy_assignment_id = azurerm_management_group_policy_assignment.name["${each.value.assignment_type}-${each.value.policy_acronym}-${each.value.assignment_unique_scope}"].id
  exemption_category   = each.value.exemption_category
}

resource "azurerm_management_group_policy_exemption" "MG_assignment" {
  for_each = {
    for unique in local.exemptions_list : "${unique.exemption_category}-${unique.type}-${unique.policy_acronym}-${unique.unique_scope}" => unique if unique.type == "MG" && unique.assignment_type == "MG"
  }
  name                 = each.key
  management_group_id  = each.value.scope
  policy_assignment_id = azurerm_management_group_policy_assignment.name["${each.value.assignment_type}-${each.value.policy_acronym}-${each.value.assignment_unique_scope}"].id
  exemption_category   = each.value.exemption_category
}