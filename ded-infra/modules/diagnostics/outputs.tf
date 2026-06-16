output "diagnostic_setting_ids" {
  value = { for k, v in azurerm_monitor_diagnostic_setting.diag : k => v.id }
}