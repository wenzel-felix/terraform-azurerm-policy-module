provider "azurerm" {
  features {}
}

resource "null_resource" "name" {
    for_each = var.policies
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
  parameters = file("policies/${each.key}/parameters.json")
  policy_rule = file("policies/${each.key}/policy_rule.json")
}
