variable "policy_name" {
  description = "Name of the WAF policy"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
}

variable "location" {
  description = "Location of the Azure Resource Group"
}

variable "custom_rule" {
  description = "List of custom rules for the WAF policy."
  type        = list(object({
    name                = string
    priority            = number
    rule_type           = string
    match_conditions    = list(object({
      match_variables = list(object({
        variable_name = string
        selector      = string
      }))
      operator           = string
      negation_condition = bool
      match_values       = list(string)
    }))
    action              = string
  }))
}


variable "policy_settings" {
  description = "Settings for the WAF policy"
  type        = object({
    enabled                     = bool
    mode                        = string
    request_body_check          = bool
    file_upload_limit_in_mb     = number
    max_request_body_size_in_kb = number
  })
}

variable "exclusion" {
  description = "List of managed rules"
  type        = list(object({
      match_variable          = string
      selector                = string
      selector_match_operator = string
    }))
}
    
variable "managed_rule_set_type" {
    type = string
    description = "(optional) Provide the managed rule set type "
}    

variable "managed_rule_set_version" {
    type = string
    description = "(optional) Provide the managed rule set vaersion "
}  


variable "rule_group_override" { 
  type = list(object({
      rule_group_name = string
  }))
}

       
variable "rule" {
  type = list(object({
      id      = string
      enabled = bool
      action  = string
  }))
}