# Azure Terraform Policy Module

Terraform Module to create Policy with optional Assignments and Exemptions creation.

Type of resources are supported:

* [Policy Definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition)
* [Policy Set Definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition)
* [Management Group Policy Assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment)
* [Subscription Policy Assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment)
* [Resource Group Policy Assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment)
* [Resource Policy Assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment)
* [Management Group Policy Exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption)
* [Subscription Policy Exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption)
* [Resource Group Policy Exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_exemption)
* [Resource Policy Exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_exemption)

## Module Usage

```hcl
# Azurerm provider configuration
provider "azurerm" {
  features {}
}

module "policy" {
  source  = "felix-wenzel/policy-module/azurerm"
  version = "0.1"
  default_identity_location = "westeurope"
  custom_policies = var.custom_policies
  policy_sets = var.policy_sets
  builtIn_policies = var.builtIn_policies
}
```

>__Important__ :
If you want to run the test, you have to first add your subscription id in the "test/terraform.tfvars" file for every placeholder ("XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX")

## Default folder structure

```bash
└───main.tf
└───terraform.tfvars
└───variables.tf
└───policies
    ├───accTestPolicy
    │   └───parameters.json
    │   └───policy_rule.json
    └───accTestPolicy2
        └───parameters.json
        └───policy_rule.json
```

## Inputs

Name | Description | Type | Default
---- | ----------- | ---- | -------
`policy_config_path` | The path where the policy folders are located | string | `"policies/"`
`default_identity_location` | The Azure location the SystemAssigned Identity will be created | string | `"westeurope"`
`custom_policies` | The map including the individual parameters for each custom policy that will be created | map | `{}`
`policy_sets`  | The map including the individual parameters for each policy set that will be created | map | `{}`
`builtIn_policies`  | The map including the individual parameters for each built-in policy that will be created | map | `{}`

## Structure of the individual __custom_policy__
Name | Description | Type | Default
---- | ----------- | ---- | -------
`{key}` | The key of each custom policy represents the display_name unique to the policy and needs to be similar with the folder of the json data files. | string | `"My policy name"`
`mode` | This is a [original policy definition argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#mode) | string | `"All"`
`metadata` | This is a [original policy definition argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#metadata) adjusted to be a map instead of json string. | map | `{Category = General}`
`assignments` | This is a list containing the individual assignments of the policy definition and their exemptions | list | `-`

## Structure of the individual __builtIn_policy__
Name | Description | Type | Default
---- | ----------- | ---- | -------
`{key}` | The key of each built-in policy represents the display_name unique to the policy and needs to be similar to the display name of the built-in policy itself within Azure. | string | `"My built-in Azure policy name"`
`mode` | This is a [original policy definition argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#mode) | string | `"All"`
`metadata` | This is a [original policy definition argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#metadata) adjusted to be a map instead of json string. | map | `{Category = General}`
`assignments` | This is a list containing the individual assignments of the policy definition and their exemptions | list | `-`

## Structure of the individual __policy set__
Name | Description | Type | Default
---- | ----------- | ---- | -------
`{key}` | The key of each policy set represents the display_name unique to the policy set and can be chosen freely. | string | `"My policy set name"`
`policy_definition_references` | A list of all the defined custom and builtIn policies that the set contains. | list[string] | `[custom_policy1, builtIn_policy5, builtIn_policy4]`
`metadata` | This is a [original policy definition argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#metadata) adjusted to be a map instead of json string. | map | `{Category = General}`
`assignments` | This is a list containing the individual assignments of the policy definition and their exemptions | list | `-`

## Structure of the individual __assignments__ 
Name | Description | Type | Default
---- | ----------- | ---- | -------
`type` | The type of the resource for the assignment (needs to be aligned with the scope) | `string of ["MG", "SUB", "RG", "RES"]` | `-`
`scope` | This string can dependent on the type given be associated with either [management_group_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment#management_group_id), [subscription_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment#subscription_id), [resource_group_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment#resource_group_id) or [resource_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment#resource_id) | string | `-`
`metadata` | This is a [original policy assignment argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment#metadata) adjusted to be a map instead of json string. | map | `{Category = General}`
`exemptions` | This is a list containing the individual exemptions of the policy assignment | list | `-`

## Structure of the individual __exemptions__ 
Name | Description | Type | Default
---- | ----------- | ---- | -------
`type` | The type of the resource for the assignment (needs to be aligned with the scope) | `string of ["MG", "SUB", "RG", "RES"]` | `-`
`exemption_category` | This is a [original policy exemption argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption#exemption_category) | `string of ["Waiver", "Mitigated"]` | `-`
`scope` | This string can dependent on the type given be associated with either [management_group_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption#management_group_id), [subscription_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption#subscription_id), [resource_group_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_exemption#resource_group_id) or [resource_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_exemption#resource_id) | string | `-`
`metadata` | This is a [original policy exemption argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption#metadata) adjusted to be a map instead of json string. | map | `{Category = General}`

## Outputs

Name | Description
---- | -----------
policy_set_definitions | You can reference each created policy set by using this value.
builtIn_policy_definitions | You can reference each fetched builtIn policy by using this value.
custom_policy_definitions | You can reference each created custom policy by using this value.

<br>

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | >= 2.59.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.59.0 |

## Other resources

* [Terraform AzureRM Provider Documentation](https://www.terraform.io/docs/providers/azurerm/index.html)
