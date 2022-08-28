variable "policies" {
  description = "The configuration for the policies to be installed."
}
variable "policy_definitions" {
  description = "The policy resources that are created upfront and referenced in the assignments."
}
variable "default_identity_location" {
  description = "The default location for the policies' identities."
}