policy_config_path = "policies/"
custom_policies = {
  "accTestPolicy" : {
    mode         = "Indexed"
    display_name = "acceptance test policy definition"
    metadata     = <<METADATA
        {
            "category": "General"
        }
    METADATA
    assignments = [
      {
        type     = "RG"
        scope    = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2"
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
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
        type       = "RG"
        scope      = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example1"
        metadata   = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = []
      },
      {
        type       = "RES"
        scope      = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example1/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad1"
        metadata   = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = []
      }
    ]
  },
  "accTestPolicy2" : {
    mode         = "All"
    display_name = "acceptance test policy definition2"
    metadata     = <<METADATA
        {
            "category": "General"
        }
    METADATA
    assignments  = []
  },
  "accTestPolicy3" : {
    mode         = "All"
    display_name = "acceptance test policy definition3"
    metadata     = <<METADATA
        {
            "category": "General"
        }
    METADATA
    assignments  = []
  }
}
policy_sets = {
  "accTestPolicySet" : {
    display_name = "acceptance test policy set definition for 2 and 3"
    metadata     = <<METADATA
        {
            "category": "General"
        }
    METADATA
    policy_definition_references = [
      "accTestPolicy2",
      "accTestPolicy3",
      "Audit VMs that do not use managed disks"
    ]
    assignments = [
      {
        type     = "RG"
        scope    = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2"
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
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
        type     = "RG"
        scope    = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2"
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = [
          {
            type               = "RES"
            scope              = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
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
        type       = "RG"
        scope      = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example1"
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