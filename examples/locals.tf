locals {
  assignment_file_content = <<EOF
    [
        {
            "policyDisplayName": "Allowed locations 2",
            "scope": "${azurerm_resource_group.example2.id}",
            "non_compliance_message": "non_compliance_message",
            "identity": {
                "use": true,
                "location": ""
            },
            "parameters": {
                "listOfAllowedLocations": {
                    "value": [
                        "eastus"
                    ]
                }
            },
            "metadata": {
                "category": "General"
            },
            "exemptions": [
                {
                    "scope": "${azurerm_storage_account.example2.id}",
                    "exemption_category": "Waiver",
                    "metadata": {
                        "category": "General"
                    }
                }
            ]
        },
        {
            "policyDisplayName": "Allowed locations 2",
            "scope": "${azurerm_resource_group.example1.id}",
            "identity": {
                "use": false,
                "location": ""
            },
            "parameters": {
                "listOfAllowedLocations": {
                    "value": [
                        "eastus"
                    ]
                }
            },
            "non_compliance_message": "non_compliance_message",
            "metadata": {
                "category": "General"
            },
            "exemptions": []
        },
        {
            "policyDisplayName": "Allowed locations 2",
            "scope": "${azurerm_storage_account.example1.id}",
            "identity": {
                "use": false,
                "location": ""
            },
            "parameters": {
                "listOfAllowedLocations": {
                    "value": [
                        "eastus"
                    ]
                }
            },
            "non_compliance_message": "non_compliance_message",
            "metadata": {
                "category": "General"
            },
            "exemptions": []
        },
        {
            "policyDisplayName": "Audit VMs that do not use managed disks",
            "scope": "${azurerm_resource_group.example2.id}",
            "identity": {
                "use": false,
                "location": ""
            },
            "parameters": {},
            "non_compliance_message": "non_compliance_message",
            "metadata": {
                "category": "General"
            },
            "exemptions": [
                {
                    "scope": "${azurerm_storage_account.example2.id}",
                    "exemption_category": "Waiver",
                    "metadata": {
                        "category": "General"
                    }
                }
            ]
        }
    ]
  EOF
}