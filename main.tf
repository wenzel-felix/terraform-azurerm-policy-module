############ Custom Policy Definitions ############

module "custom_policies" {
  source          = "./custom_policies/"
  custom_policies = var.custom_policies
}

############ BuiltIn Policy Definitions ############

module "builtIn_policies" {
  source           = "./builtIn_policies/"
  builtIn_policies = var.builtIn_policies
}

############ Policy Set Definitions ############

module "policy_sets" {
  source             = "./policy_sets/"
  policy_sets        = var.policy_sets
  policy_definitions = merge(module.custom_policies.policy_definitions, module.builtIn_policies.policy_definitions)
}

