variable "custom_policies" {
  description = "The configuration for the policies to be installed."
}
variable "policy_config_path" {
  description = "The path to the policy folders. (eg. ./policies/)"
}
variable "policy_sets" {
  description = "The policy sets to be installed."
}

variable "default_identity_location" {
  description = "The default location for the policies' identities."
  default     = "westeurope"
}

variable "policy_assignments_path" {
  description = "The path to the policy assignments folder. (eg. ./policy_assignments/)"
  default     = "policy_assignments/"
}