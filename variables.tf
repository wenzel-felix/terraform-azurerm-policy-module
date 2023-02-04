variable "policy_definitions_path" {
  description = "The path to the policy folders. (eg. './policies/')"
  default     = "policies/"
  type        = string
}

variable "default_identity_location" {
  description = "The default location for the policies' identities."
  type        = string
}

variable "policy_assignments_path" {
  description = "The path to the policy assignments folder. (eg. ./policy_assignments/)"
  default     = "policy_assignments/"
}