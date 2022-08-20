policy_config_path = "policies/"
policies = {
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
        type     = "RG" ### MG/SUB/RG/RES
        scope    = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2"
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
        exemptions = [
          {
            type               = "RES" ### MG/SUB/RG/RES
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
        type     = "RG" ### MG/SUB/RG/RES
        scope    = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example1"
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
      },
      {
        type     = "RES" ### MG/SUB/RG/RES
        scope    = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example1/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad1"
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
      }
    ]
  }
}