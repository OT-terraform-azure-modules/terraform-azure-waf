output "web_application_firewall_policy_id" {
  value = azurerm_web_application_firewall_policy.default.id
}

output "web_application_firewall_policy_name" {
  value = azurerm_web_application_firewall_policy.default.name
}

output "web_application_firewall_policy_resource_group" {
  value = azurerm_web_application_firewall_policy.default.resource_group_name
}

output "web_application_firewall_policy_location" {
  value = azurerm_web_application_firewall_policy.default.location
}

