output "function_app_name" {
  value = azurerm_function_app.func_jrpdl001.name
  description = "Deployed function app name"
}

output "function_app_default_hostname" {
  value = azurerm_function_app.func_jrpdl001.default_hostname
  description = "Deployed function app hostname"
}