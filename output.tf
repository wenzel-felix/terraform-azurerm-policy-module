output "policy_set_definitions" {
  value = module.policy_sets.policy_set_definitions
}
output "builtIn_policy_definitions" {
  value = module.builtIn_policies.policy_definitions
}
output "custom_policy_definitions" {
  value = module.custom_policies.policy_definitions
}