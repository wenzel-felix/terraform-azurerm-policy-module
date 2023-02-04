# Azure Terraform Policy Module

Terraform module to create policies with optional assignments and exemptions creation.
The module supports a file based approach compatible with the default azure policy definition files.

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


```
## Default folder structure

```bash
.
├── main.tf
├── variables.tf
├── policy_definitions/
│   ├── policy1.json
│   └── policy2.json
└── policy_assignments/
    └── policy_assignment1.json
```


For more information on the structure of the role assignment and policy definition files follow these references:
[assignment example](examples/simple-example/policy_assignments/assignment.json.example)
[definition example](examples/simple-example/policies/testPolicy.json)

## Other resources

* [Terraform AzureRM Provider Documentation](https://www.terraform.io/docs/providers/azurerm/index.html)
