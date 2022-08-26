variable "custom_policies" {
  description = "The configuration for the policies to be installed."
  type = map(object(
    {
      mode         = string
      display_name = string
      metadata     = string
      assignments = list(object({
        type     = string
        scope    = string
        metadata = string
        exemptions = list(object({
          type               = string
          scope              = string
          metadata           = string
          exemption_category = string
        }))
      }))
    }
  ))
}
variable "policy_config_path" {
  description = "The path to the policy folders. (eg. './policies/')"
  default     = "policies/"
  type        = string
}
variable "policy_sets" {
  description = "The policy sets to be installed."
  type = map(object(
    {
      display_name                  = string
      metadata                      = string
      policy_definitions_references = list(string)
      assignments = list(object({
        type     = string
        scope    = string
        metadata = string
        exemptions = list(object({
          type               = string
          scope              = string
          metadata           = string
          exemption_category = string
        }))
      }))
    }
  ))
}
variable "builtIn_policies" {
  description = "The configuration for the policies to be installed."
  type = map(object(
    {
      assignments = list(object({
        type     = string
        scope    = string
        metadata = string
        exemptions = list(object({
          type               = string
          scope              = string
          metadata           = string
          exemption_category = string
        }))
      }))
    }
  ))
}