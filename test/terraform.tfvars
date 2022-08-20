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
        type     = "RG" 
        scope    = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example2"
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
        type     = "RG" 
        scope    = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example1"
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
      },
      {
        type     = "RES" 
        scope    = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/example1/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad1"
        metadata = <<METADATA
        {
            "category": "General"
        }
    METADATA
      }
    ]
  }
}