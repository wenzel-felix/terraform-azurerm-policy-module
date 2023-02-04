############ Custom Policy Definitions ############

module "definitions" {
  source          = "./policy_definitions/"
  policy_definitions_path = var.policy_definitions_path
}

############ Policy Assignments and Exmeptions ############

module "assignments" {
  depends_on = [
    module.definitions,
  ]
  source                    = "./policy_assignments/"
  default_identity_location = var.default_identity_location
  policy_assignments_path   = var.policy_assignments_path
}