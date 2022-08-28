policy_config_path        = "policies/"
default_identity_location = "westeurope"
custom_policies = {
  "acceptance test policy definition" : {
    mode     = "Indexed"
    metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
    assignments = [
      {
        type  = "RG"
        scope = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2"
        identity = {
          use      = true
          location = ""
        }
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
            exemption_category = "Waiver"
            metadata           = <<METADATA
        {
            "category": "General"
        }
    METADATA
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
        metadata   = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = []
      },
      {
        type  = "RES"
        scope = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example1/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad1"
        identity = {
          use      = false
          location = ""
        }
        metadata   = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = []
      }
    ]
  },
  "acceptance test policy definition2" : {
    mode        = "All"
    metadata    = <<METADATA
        {
            "category": "General"
        }
    METADATA
    assignments = []
  },
  "acceptance test policy definition3" : {
    mode        = "All"
    metadata    = <<METADATA
        {
            "category": "General"
        }
    METADATA
    assignments = []
  }
}
policy_sets = {
  "acceptance test policy set definition for 2 and 3" : {
    metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
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
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
            exemption_category = "Waiver"
            metadata           = <<METADATA
        {
            "category": "General"
        }
    METADATA
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
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
            exemption_category = "Waiver"
            metadata           = <<METADATA
        {
            "category": "General"
        }
    METADATA
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
        metadata   = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = []
      }
    ]
  }
}