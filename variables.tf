variable "policy_config_path" {
  description = "The path to the policy folders. (eg. './policies/')"
  default     = "policies/"
  type        = string
}
variable "custom_policies" {
  description = "The configuration for the policies to be installed."
  type = map(object(
    {
      assignments = list(object({
        scope                  = string
        metadata               = map(any)
        parameters             = map(any)
        non_compliance_message = string
        identity = object({
          use      = bool
          location = string
        })
        exemptions = list(object({
          scope              = string
          metadata           = map(any)
          exemption_category = string
        }))
      }))
    }
  ))
}

variable "policy_sets" {
  description = "The policy sets to be installed."
  type = map(object(
    {
      metadata                     = map(any)
      policy_definition_references = list(string)
      assignments = list(object({
        scope                  = string
        parameters             = map(any)
        metadata               = map(any)
        non_compliance_message = string
        identity = object({
          use      = bool
          location = string
        })
        exemptions = list(object({
          scope              = string
          metadata           = map(any)
          exemption_category = string
        }))
      }))
    }
  ))
}

variable "default_identity_location" {
  description = "The default location for the policies' identities."
  type        = string
}

variable "policy_assignments_path" {
  description = "The path to the policy assignments folder. (eg. ./policy_assignments/)"
  default     = "policy_assignments/"
}