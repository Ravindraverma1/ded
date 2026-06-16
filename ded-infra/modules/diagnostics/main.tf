data "azurerm_monitor_diagnostic_categories" "cats" {
  for_each    = var.targets
  resource_id = each.value
}

resource "azurerm_monitor_diagnostic_setting" "diag" {
  for_each                   = var.targets
  name                       = "diag-${each.key}-to-law"
  target_resource_id         = each.value
  log_analytics_workspace_id = var.law_id

  dynamic "enabled_log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.cats[each.key].log_category_types)
    content {
      category = enabled_log.value
    }
  }

dynamic "enabled_metric" {
  for_each = toset(data.azurerm_monitor_diagnostic_categories.cats[each.key].metrics)
  content {
    category = enabled_metric.value
  }
}
}