policy_config_path        = "policies/"
default_identity_location = "westeurope"
custom_policies = {
  "acceptance test policy definition" : {
    mode     = "Indexed"
    metadata = { category = "General" }
    assignments = [
      {
        type  = "RG"
        scope = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2"
        identity = {
          use      = true
          location = ""
        }
        metadata = { category = "General" }
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
            exemption_category = "Waiver"
            metadata           = { category = "General" }
          }
        ]
      },
      {
        type  = "RG"
        scope = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example1"
        identity = {
          use      = false
          location = ""
        }
        metadata   = { category = "General" }
        exemptions = []
      },
      {
        type  = "RES"
        scope = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example1/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad1"
        identity = {
          use      = false
          location = ""
        }
        metadata   = { category = "General" }
        exemptions = []
      }
    ]
  },
  "acceptance test policy definition2" : {
    mode        = "All"
    metadata    = { category = "General" }
    assignments = []
  },
  "acceptance test policy definition3" : {
    mode        = "All"
    metadata    = { category = "General" }
    assignments = []
  }
}
policy_sets = {
  "acceptance test policy set definition for 2 and 3" : {
    metadata = { category = "General" }
    policy_definition_references = [
      "acceptance test policy definition2",
      "acceptance test policy definition3",
      "Audit VMs that do not use managed disks"
    ]
    assignments = [
      {
        type  = "RG"
        scope = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2"
        identity = {
          use      = false
          location = ""
        }
        metadata = { category = "General" }
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
            exemption_category = "Waiver"
            metadata           = { category = "General" }
          }
        ]
      }
    ]
  }
}
builtIn_policies = {
  "Audit VMs that do not use managed disks" : {
    assignments = [
      {
        type  = "RG"
        scope = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2"
        identity = {
          use      = false
          location = ""
        }
        metadata = { category = "General" }
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
            exemption_category = "Waiver"
            metadata           = { category = "General" }
          }
        ]
      }
    ]
  },
  "API Management calls to API backends should not bypass certificate thumbprint or name validation" : {
    assignments = [
      {
        type  = "RG"
        scope = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example1"
        identity = {
          use      = false
          location = ""
        }
        metadata   = { category = "General" }
        exemptions = []
      }
    ]
  }
}