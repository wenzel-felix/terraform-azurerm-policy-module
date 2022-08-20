# Azure Terraform Policy Module

Terraform Module to create Policy with optional Assignments and Exemptions creation.

Type of resources are supported:

* [Policy Definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition)
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
  source  = "felix-wenzel/policy/azurerm"
  version = "0.1"
  policy_config_path = "policies/"  # policy_config_path is set to "policies/" by default
  policies = var.policies
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
    └───accTestPolicy
        └───parameters.json
        └───policy_rule.json
```

## Inputs

Name | Description | Type | Default
---- | ----------- | ---- | -------
`policy_config_path` | The path where the policy folders are located | string | `"policies/"`
`policies` | The policies map includes individual policies to be implemented | map | `{}`

## Structure of the individual __policies__
Name | Description | Type | Default
---- | ----------- | ---- | -------
`policy` | The policy itself contains all parameters needed for the resource and has a key unique to the policy similar to the folder of the json data files. | map | `-`
`mode` | This is a [original policy definition argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#mode) | string | `"All"`
`disply_name` | This is a [original policy definition argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#display_name) | string | `-`
`metadata` | This is a [original policy definition argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition#metadata) | string | `-`
`assignments` | This is a list containing the individual assignments of the policy definition and their exemptions | list | `-`

## Structure of the individual __assignments__ 
Name | Description | Type | Default
---- | ----------- | ---- | -------
`type` | The type of the resource for the assignment (needs to be aligned with the scope) | `string of ["MG", "SUB", "RG", "RES"]` | `-`
`scope` | This string can dependent on the type given be associated with either [management_group_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment#management_group_id), [subscription_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment#subscription_id), [resource_group_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment#resource_group_id) or [resource_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment#resource_id) | string | `-`
`metadata` | This is a [original policy assignment argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment#metadata) | string | `-`
`exemptions` | This is a list containing the individual exemptions of the policy assignment | list | `-`

## Structure of the individual __exemptions__ 
Name | Description | Type | Default
---- | ----------- | ---- | -------
`type` | The type of the resource for the assignment (needs to be aligned with the scope) | `string of ["MG", "SUB", "RG", "RES"]` | `-`
`exemption_category` | This is a [original policy exemption argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption#exemption_category) | `string of ["Waiver", "Mitigated"]` | `-`
`scope` | This string can dependent on the type given be associated with either [management_group_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption#management_group_id), [subscription_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption#subscription_id), [resource_group_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_exemption#resource_group_id) or [resource_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_exemption#resource_id) | string | `-`
`metadata` | This is a [original policy exemption argument](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption#metadata) | string | `-`

## Outputs

Name | Description
---- | -----------

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
