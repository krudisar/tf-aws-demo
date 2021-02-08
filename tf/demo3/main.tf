provider "azurerm" {
}

resource "azurerm_resource_group" "test" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_sql_server" "test" {
    name                         = "${var.prefix}azuresqlsrv"
    resource_group_name          = azurerm_resource_group.test.name
    location                     = azurerm_resource_group.test.location
    version                      = "12.0"
    administrator_login          = "admin-kr"
    administrator_login_password = "VMware1!"
}

resource "azurerm_sql_firewall_rule" "test" {
  name                = "${var.prefix}AlllowAzureServices"
  resource_group_name = azurerm_resource_group.test.name
  server_name         = azurerm_sql_server.test.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_database" "test" {
  name                             = "${var.prefix}azuredb"
  resource_group_name              = azurerm_resource_group.test.name
  location                         = azurerm_resource_group.test.location
  server_name                      = azurerm_sql_server.test.name
  edition                          = "Standard"
  requested_service_objective_name = "S1"
}

resource "azurerm_app_service_plan" "test" {
  name                = "${var.prefix}appserviceplan"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "test" {
  name                = "${var.prefix}-app-service"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  app_service_plan_id = azurerm_app_service_plan.test.id

  site_config {
    dotnet_framework_version = "v4.0"
  }

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=tcp:${azurerm_sql_database.test.server_name}.database.windows.net;Database=${azurerm_sql_database.test.name};User ID=changeme@changeme;Password=changene;Trusted_Connection=False;Encrypt=True;"
  }  

}
