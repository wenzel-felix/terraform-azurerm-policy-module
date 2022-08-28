variable "policy_config_path" {
  description = "The path to the policy folders. (eg. './policies/')"
  default     = "policies/"
  type        = string
}
variable "custom_policies" {
  description = "The configuration for the policies to be installed."
  type = map(object(
    {
      mode     = string
      metadata = string
      assignments = list(object({
        type                   = string
        scope                  = string
        metadata               = map(any)
        non_compliance_message = string
        identity = object({
          use      = bool
          location = string
        })
        exemptions = list(object({
          type               = string
          scope              = string
          metadata           = map(any)
          exemption_category = string
        }))
      }))
    }
  ))
  validation {
    condition = alltrue([
      for policy in var.custom_policies :
      policy.assignments != [] ? alltrue([
        for type in policy.assignments[*].type :
        contains(["RES", "RG", "SUB", "MG"], type)
      ]) : true
    ])
    error_message = "The assignment type can only be RES, RG, SUB or MG."
  }

  validation {
    condition = alltrue([
      for policy in var.custom_policies :
      policy.assignments != [] ? alltrue([
        for assignment in policy.assignments :
        assignment.exemptions != [] ? alltrue([
          for type in assignment.exemptions[*].type :
          contains(["RES", "RG", "SUB", "MG"], type)
        ]) : true
      ]) : true
    ])
    error_message = "The exemption type can only be RES, RG, SUB or MG."
  }

  validation {
    condition = alltrue([
      for policy in var.custom_policies :
      policy.assignments != [] ? alltrue([
        for assignment in policy.assignments :
        assignment.exemptions != [] ? alltrue([
          for exemption in assignment.exemptions :
          length(regexall(assignment.scope, exemption.scope)) > 0
        ]) : true
      ]) : true
    ])
    error_message = "The exemption scope is not in the scope of the assignment."
  }
}
variable "policy_sets" {
  description = "The policy sets to be installed."
  type = map(object(
    {
      metadata                     = string
      policy_definition_references = list(string)
      assignments = list(object({
        type                   = string
        scope                  = string
        metadata               = map(any)
        non_compliance_message = string
        identity = object({
          use      = bool
          location = string
        })
        exemptions = list(object({
          type               = string
          scope              = string
          metadata           = map(any)
          exemption_category = string
        }))
      }))
    }
  ))

  validation {
    condition = alltrue([
      for policy in var.policy_sets :
      policy.assignments != [] ? alltrue([
        for type in policy.assignments[*].type :
        contains(["RES", "RG", "SUB", "MG"], type)
      ]) : true
    ])
    error_message = "The assignment type can only be RES, RG, SUB or MG."
  }

  validation {
    condition = alltrue([
      for policy in var.policy_sets :
      policy.assignments != [] ? alltrue([
        for assignment in policy.assignments :
        assignment.exemptions != [] ? alltrue([
          for type in assignment.exemptions[*].type :
          contains(["RES", "RG", "SUB", "MG"], type)
        ]) : true
      ]) : true
    ])
    error_message = "The exemption type can only be RES, RG, SUB or MG."
  }

  validation {
    condition = alltrue([
      for policy in var.policy_sets :
      policy.assignments != [] ? alltrue([
        for assignment in policy.assignments :
        assignment.exemptions != [] ? alltrue([
          for exemption in assignment.exemptions :
          length(regexall(assignment.scope, exemption.scope)) > 0
        ]) : true
      ]) : true
    ])
    error_message = "The exemption scope is not in the scope of the assignment."
  }
}
variable "builtIn_policies" {
  description = "The configuration for the policies to be installed."
  type = map(object(
    {
      assignments = list(object({
        type                   = string
        scope                  = string
        metadata               = map(any)
        non_compliance_message = string
        identity = object({
          use      = bool
          location = string
        })
        exemptions = list(object({
          type               = string
          scope              = string
          metadata           = map(any)
          exemption_category = string
        }))
      }))
    }
  ))

  validation {
    condition = alltrue([
      for policy in var.builtIn_policies :
      policy.assignments != [] ? alltrue([
        for type in policy.assignments[*].type :
        contains(["RES", "RG", "SUB", "MG"], type)
      ]) : true
    ])
    error_message = "The assignment type can only be RES, RG, SUB or MG."
  }

  validation {
    condition = alltrue([
      for policy in var.builtIn_policies :
      policy.assignments != [] ? alltrue([
        for assignment in policy.assignments :
        assignment.exemptions != [] ? alltrue([
          for type in assignment.exemptions[*].type :
          contains(["RES", "RG", "SUB", "MG"], type)
        ]) : true
      ]) : true
    ])
    error_message = "The exemption type can only be RES, RG, SUB or MG."
  }

  validation {
    condition = alltrue([
      for policy in var.builtIn_policies :
      policy.assignments != [] ? alltrue([
        for assignment in policy.assignments :
        assignment.exemptions != [] ? alltrue([
          for exemption in assignment.exemptions :
          length(regexall(assignment.scope, exemption.scope)) > 0
        ]) : true
      ]) : true
    ])
    error_message = "The exemption scope is not in the scope of the assignment."
  }
}
variable "default_identity_location" {
  description = "The default location for the policies' identities."
  type        = string
}