############ Custom Policy Definitions ############

module "custom_policies" {
  source          = "./custom_policies/"
  custom_policies = var.custom_policies
}

############ Policy Set Definitions ############

module "policy_sets" {
  source             = "./policy_sets/"
  policy_sets        = var.policy_sets
  policy_definitions = merge(module.custom_policies.policy_definitions)
}

############ Policy Assignments and Exmeptions ############

module "assignments" {
  depends_on = [
    module.custom_policies,
    module.policy_sets
  ]
  source                    = "./assignments/"
  default_identity_location = var.default_identity_location
  policy_assignments_path   = var.policy_assignments_path
  policies                  = merge(var.policy_sets, var.custom_policies)
  policy_definitions        = merge(module.custom_policies.policy_definitions, module.policy_sets.policy_set_definitions)
}