policy_config_path        = "policies/"
default_identity_location = "eastus"
custom_policies = {
  "acceptance test policy definition" : {
    assignments = [
      {
        scope                  = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2"
        non_compliance_message = "non_compliance_message"
        identity = {
          use      = true
          location = ""
        }
        parameters = {
          "listOfAllowedLocations" = {
            type  = "Array"
            value = [
              "eastus"
            ]
          }
        }
        metadata = { category = "General" }
        exemptions = [
          {
            scope              = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
            exemption_category = "Waiver"
            metadata           = { category = "General" }
          }
        ]
      },
      {
        scope = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example1"
        identity = {
          use      = false
          location = ""
        }
        parameters = {
          "listOfAllowedLocations" = {
            type  = "Array"
            value = [
              "eastus"
            ]
          }
        }
        non_compliance_message = "non_compliance_message"
        metadata               = { category = "General" }
        exemptions             = []
      },
      {
        scope = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example1/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad1"
        identity = {
          use      = false
          location = ""
        }
        parameters = {
          "listOfAllowedLocations" = {
            type  = "Array"
            value = [
              "eastus"
            ]
          }
        }
        non_compliance_message = "non_compliance_message"
        metadata               = { category = "General" }
        exemptions             = []
      }
    ]
  }
}
policy_sets = {
  "acceptance test policy set definition" : {
    metadata = { category = "General" }
    policy_definition_references = [
      "helicopter187"
      ]
    assignments = [
      {
        scope = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2"
        identity = {
          use      = false
          location = ""
        }
        parameters = {}
        non_compliance_message = "non_compliance_message"
        metadata               = { category = "General" }
        exemptions = [
          {
            scope              = "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd/resourceGroups/example2/providers/Microsoft.Storage/storageAccounts/geantnamelllawdadad2"
            exemption_category = "Waiver"
            metadata           = { category = "General" }
          }
        ]
      }
    ]
  }
}