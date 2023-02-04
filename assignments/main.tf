locals {
  assignments_list = toset(flatten([
    for k, v in var.policies :
    lookup(v, "assignments", false) != false ?
    [
      for assignment in v.assignments : {
        scope                  = assignment.scope
        unique_scope           = element(split("/", assignment.scope), length(split("/", assignment.scope)) - 1)
        identity               = assignment.identity
        parameters             = jsonencode(assignment.parameters)
        policy                 = k
        policy_acronym         = join("", regexall("[A-Z]+", title(k)))
        metadata               = jsonencode(assignment.metadata)
        non_compliance_message = assignment.non_compliance_message
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
          assignment_scope         = assignment.scope
          assignment_unique_scope = element(split("/", assignment.scope), length(split("/", assignment.scope)) - 1)
          scope                   = exemption.scope
          unique_scope            = element(split("/", exemption.scope), length(split("/", exemption.scope)) - 1)
          policy                  = k
          policy_acronym          = join("", regexall("[A-Z]+", title(k)))
          exemption_category      = exemption.exemption_category
          metadata                = jsonencode(exemption.metadata)
        }
      ] : []
    ] : []
    ]
  ))
}

resource "random_uuid" "main" {
  for_each = {
    for policy_assignment in local.policy_assignments_list :
    "${policy_assignment.policyDisplayName}-${policy_assignment.scope}" => policy_assignment
  }
}

locals {
  policy_assignment_files = toset(fileset(var.policy_assignments_path, "**/*.json"))
  policy_assignments_list = flatten(concat([for policy_assignment_file, _ in local.policy_assignment_files : jsondecode(file("${var.policy_assignments_path}${policy_assignment_file}"))]))
  policy_assignments_map = {
    for policy_assignment in local.policy_assignments_list :
    "${policy_assignment.policyDisplayName}-${policy_assignment.scope}" => merge(policy_assignment, {"uuid": random_uuid.main["${policy_assignment.policyDisplayName}-${policy_assignment.scope}"].result})
  }
  unique_policies_list = distinct([
    for policy_assignment in local.policy_assignments_list :
    "${policy_assignment.policyDisplayName}"
  ])
  assignment_exemptions_list = toset(flatten([for assignment in local.policy_assignments_list :
      lookup(assignment, "exemptions", false) != false ?
      [
        for exemption in assignment.exemptions : {
          assignment_scope         = assignment.scope
          assignment_unique_scope = element(split("/", assignment.scope), length(split("/", assignment.scope)) - 1)
          scope                   = exemption.scope
          unique_scope            = element(split("/", exemption.scope), length(split("/", exemption.scope)) - 1)
          policy_display_name                  = assignment.policyDisplayName
          policy_acronym          = join("", regexall("[A-Z]+", title(assignment.policyDisplayName)))
          exemption_category      = exemption.exemption_category
          metadata                = jsonencode(exemption.metadata)
        }
      ] : []]))
}

############ Policy Assignments ############

data "azurerm_policy_definition" "name" {
  for_each = toset(local.unique_policies_list)
  display_name = each.key
}

resource "azurerm_management_group_policy_assignment" "name" {
  for_each = {
    for key, assignment in local.policy_assignments_map : key => assignment if lower(split("/", assignment.scope)[length(split("/", assignment.scope))-2]) == "managementgroups"
  }
  name                 = each.value.uuid
  policy_definition_id = data.azurerm_policy_definition.name[each.value.policyDisplayName].id
  management_group_id  = each.value.scope
  metadata             = each.value.metadata != null ? jsonencode(each.value.metadata) : null
  parameters           = each.value.parameters != null ? jsonencode(each.value.parameters) : null
  non_compliance_message {
    content = each.value.non_compliance_message
  }

  dynamic "identity" {
    for_each = lookup(each.value.identity, "use", false) ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }
  location = lookup(each.value.identity, "location", var.default_identity_location) == "" && lookup(each.value.identity, "use", false) ? var.default_identity_location : lookup(each.value.identity, "location", var.default_identity_location)
}

resource "azurerm_subscription_policy_assignment" "name" {
  for_each = {
    for key, assignment in local.policy_assignments_map : key => assignment if lower(split("/", assignment.scope)[length(split("/", assignment.scope))-2]) == "subscriptions"
  }
  name                 = each.value.uuid
  policy_definition_id = data.azurerm_policy_definition.name[each.value.policyDisplayName].id
  subscription_id      = each.value.scope
  metadata             = each.value.metadata != null ? jsonencode(each.value.metadata) : null
  parameters           = each.value.parameters != null ? jsonencode(each.value.parameters) : null
  non_compliance_message {
    content = each.value.non_compliance_message
  }

  dynamic "identity" {
    for_each = lookup(each.value.identity, "use", false) ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }
  location = lookup(each.value.identity, "location", var.default_identity_location) == "" && lookup(each.value.identity, "use", false) ? var.default_identity_location : lookup(each.value.identity, "location", var.default_identity_location)
}

resource "azurerm_resource_group_policy_assignment" "name" {
  for_each = {
    for key, assignment in local.policy_assignments_map : key => assignment if lower(split("/", assignment.scope)[length(split("/", assignment.scope))-2]) == "resourcegroups"
  }
  name                 = each.value.uuid
  policy_definition_id = data.azurerm_policy_definition.name[each.value.policyDisplayName].id
  resource_group_id    = each.value.scope
  metadata             = each.value.metadata != null ? jsonencode(each.value.metadata) : null
  parameters           = each.value.parameters != null ? jsonencode(each.value.parameters) : null
  non_compliance_message {
    content = each.value.non_compliance_message
  }

  dynamic "identity" {
    for_each = lookup(each.value.identity, "use", false) ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }
  location = lookup(each.value.identity, "location", var.default_identity_location) == "" && lookup(each.value.identity, "use", false) ? var.default_identity_location : lookup(each.value.identity, "location", var.default_identity_location)
}

resource "azurerm_resource_policy_assignment" "name" {
  for_each = {
    for key, assignment in local.policy_assignments_map : key => assignment if !contains(["resourcegroups", "subscriptions", "managementgroups"], lower(split("/", assignment.scope)[length(split("/", assignment.scope))-2]))
  }
  name                 = each.value.uuid
  policy_definition_id = data.azurerm_policy_definition.name[each.value.policyDisplayName].id
  resource_id          = each.value.scope
  metadata             = each.value.metadata != null ? jsonencode(each.value.metadata) : null
  parameters           = each.value.parameters != null ? jsonencode(each.value.parameters) : null
  non_compliance_message {
    content = each.value.non_compliance_message
  }

  dynamic "identity" {
    for_each = lookup(each.value.identity, "use", false) ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }
  location = lookup(each.value.identity, "location", var.default_identity_location) == "" && lookup(each.value.identity, "use", false) ? var.default_identity_location : lookup(each.value.identity, "location", var.default_identity_location)
}

############ Policy Exemptions ############

resource "azurerm_resource_policy_exemption" "RG_assignment" {
  for_each = {
    for unique in local.assignment_exemptions_list : "${unique.exemption_category}-${unique.policy_acronym}-${unique.unique_scope}" => unique if !contains(["resourcegroups", "subscriptions", "managementgroups"], lower(split("/", unique.scope)[length(split("/", unique.scope))-2])) && lower(split("/", unique.assignment_scope)[length(split("/", unique.assignment_scope))-2]) == "resourcegroups"
  }
  name                 = each.key
  resource_id          = each.value.scope
  policy_assignment_id = azurerm_resource_group_policy_assignment.name["${each.value.policy_display_name}-${each.value.assignment_scope}"].id
  exemption_category   = each.value.exemption_category
  metadata             = each.value.metadata
}

resource "azurerm_resource_policy_exemption" "SUB_assignment" {
  for_each = {
    for unique in local.assignment_exemptions_list : "${unique.exemption_category}-${unique.policy_acronym}-${unique.unique_scope}" => unique if !contains(["resourcegroups", "subscriptions", "managementgroups"], lower(split("/", unique.scope)[length(split("/", unique.scope))-2])) && lower(split("/", unique.assignment_scope)[length(split("/", unique.assignment_scope))-2]) == "subscriptions"
  }
  name                 = each.key
  resource_id          = each.value.scope
  policy_assignment_id = azurerm_subscription_policy_assignment.name["${each.value.policy_display_name}-${each.value.assignment_scope}"].id
  exemption_category   = each.value.exemption_category
  metadata             = each.value.metadata
}

resource "azurerm_resource_policy_exemption" "MG_assignment" {
  for_each = {
    for unique in local.assignment_exemptions_list : "${unique.exemption_category}-${unique.policy_acronym}-${unique.unique_scope}" => unique if !contains(["resourcegroups", "subscriptions", "managementgroups"], lower(split("/", unique.scope)[length(split("/", unique.scope))-2])) && lower(split("/", unique.assignment_scope)[length(split("/", unique.assignment_scope))-2]) == "managementgroups"
  }
  name                 = each.key
  resource_id          = each.value.scope
  policy_assignment_id = azurerm_management_group_policy_assignment.name["${each.value.policy_display_name}-${each.value.assignment_scope}"].id
  exemption_category   = each.value.exemption_category
  metadata             = each.value.metadata
}

resource "azurerm_resource_group_policy_exemption" "SUB_assignment" {
  for_each = {
    for unique in local.assignment_exemptions_list : "${unique.exemption_category}-${unique.policy_acronym}-${unique.unique_scope}" => unique if lower(split("/", unique.scope)[length(split("/", unique.scope))-2]) == "resourcegroups" && lower(split("/", unique.assignment_scope)[length(split("/", unique.assignment_scope))-2]) == "subscriptions"
  }
  name                 = each.key
  resource_group_id    = each.value.scope
  policy_assignment_id = azurerm_subscription_policy_assignment.name["${each.value.policy_display_name}-${each.value.assignment_scope}"].id
  exemption_category   = each.value.exemption_category
  metadata             = each.value.metadata
}

resource "azurerm_resource_group_policy_exemption" "MG_assignment" {
  for_each = {
    for unique in local.assignment_exemptions_list : "${unique.exemption_category}-${unique.policy_acronym}-${unique.unique_scope}" => unique if lower(split("/", unique.scope)[length(split("/", unique.scope))-2]) == "resourcegroups" && lower(split("/", unique.assignment_scope)[length(split("/", unique.assignment_scope))-2]) == "managementgroups"
  }
  name                 = each.key
  resource_group_id    = each.value.scope
  policy_assignment_id = azurerm_management_group_policy_assignment.name["${each.value.policy_display_name}-${each.value.assignment_scope}"].id
  exemption_category   = each.value.exemption_category
  metadata             = each.value.metadata
}

resource "azurerm_subscription_policy_exemption" "MG_assignment" {
  for_each = {
    for unique in local.assignment_exemptions_list : "${unique.exemption_category}-${unique.policy_acronym}-${unique.unique_scope}" => unique if lower(split("/", unique.scope)[length(split("/", unique.scope))-2]) == "subscriptions" && lower(split("/", unique.assignment_scope)[length(split("/", unique.assignment_scope))-2]) == "managementgroups"
  }
  name                 = each.key
  subscription_id      = each.value.scope
  policy_assignment_id = azurerm_management_group_policy_assignment.name["${each.value.policy_display_name}-${each.value.assignment_scope}"].id
  exemption_category   = each.value.exemption_category
  metadata             = each.value.metadata
}

resource "azurerm_management_group_policy_exemption" "MG_assignment" {
  for_each = {
    for unique in local.assignment_exemptions_list : "${unique.exemption_category}-${unique.policy_acronym}-${unique.unique_scope}" => unique if lower(split("/", unique.scope)[length(split("/", unique.scope))-2]) == "managementgroups" && lower(split("/", unique.assignment_scope)[length(split("/", unique.assignment_scope))-2]) == "managementgroups"
  }
  name                 = each.key
  management_group_id  = each.value.scope
  policy_assignment_id = azurerm_management_group_policy_assignment.name["${each.value.policy_display_name}-${each.value.assignment_scope}"].id
  exemption_category   = each.value.exemption_category
  metadata             = each.value.metadata
}