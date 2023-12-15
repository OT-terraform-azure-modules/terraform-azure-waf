resource "azurerm_web_application_firewall_policy" "default" {
  name                = var.policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "custom_rules" {
    for_each = var.custom_rule
    content {
      name     = custom_rule.value.name
      priority = custom_rule.value.priority
      rule_type = custom_rule.value.rule_type

      dynamic "match_conditions" {
        for_each = custom_rule.value.match_conditions
        content {
          dynamic "match_variables" {
            for_each = match_condition.value.match_variables
            content {
              variable_name = match_variable.value.variable_name
              selector      = match_variable.value.selector
            }
          }

          operator           = match_condition.value.operator
          negation_condition = match_condition.value.negation_condition
          match_values       = match_condition.value.match_values
        }
      }

      action = custom_rule.value.action
    }
  }


 policy_settings {
    enabled                     = var.policy_settings.enabled
    mode                        = var.policy_settings.mode
    request_body_check          = var.policy_settings.request_body_check
    file_upload_limit_in_mb     = var.policy_settings.file_upload_limit_in_mb
    max_request_body_size_in_kb = var.policy_settings.max_request_body_size_in_kb
  }

 
  managed_rules {
    dynamic "exclusion" {
      for_each = var.exclusion
      content {
       match_variable          = each.value.match_variable
       selector                = each.value.selector
       selector_match_operator = each.value.selector_match_operator 
      }
    }

    managed_rule_set {
      type    = var.managed_rule_set_type
      version = var.managed_rule_set_version

      dynamic "rule_group_override" {
        for_each = var.rule_group_override
        content {
          rule_group_name = each.value.rule_group_name
          rule {
          id      = each.value.id
          enabled = each.value.enabled
          action  = each.value.action
        }
        }
        

        
      }
    }
  }
}
