variable "policies" {
  description = "The configuration for the policies to be installed."
}
variable "policy_config_path" {
  description = "The path to the policy folders. (eg. './policies/')"
  default     = "policies/"
}
