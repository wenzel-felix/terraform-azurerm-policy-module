module "policies" {
  source = "./policies/"
  policies = var.policies
}

############ Policy Set Definitions ############

module "policy_sets" {
  source = "./policy_sets/"
  policy_sets = var.policy_sets
  policy_definitions = module.policies.policy_definitions
}

