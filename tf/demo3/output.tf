output "repo_url_kr" {
    value = replace(azurerm_app_service.test.source_control.0.repo_url, "https://", "")
}

output "website_url_kr" {
  value = azurerm_app_service.test.default_site_hostname
}

output "ConnectionString" {
  value = azurerm_app_service.test.connection_string
}