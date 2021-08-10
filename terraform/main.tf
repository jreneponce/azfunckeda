terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.26"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "resource_group" {
  name      = "${var.project}-${var.environment}-resource-group"
  location  = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name                      = "${var.project}${var.environment}storage001"
  resource_group_name       = azurerm_resource_group.resource_group.name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

resource "azurerm_application_insights" "application_insights" {
  name                = "${var.project}-${var.environment}-application-insights"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  application_type    = "Node.JS"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "${var.project}-${var.environment}-app-service-plan"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  kind                = "FunctionApp"
  reserved            = true
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "func_jrpdl001" {
  name                = "${var.project}-${var.environment}-func-jrpdl001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  app_settings        = {
    "WEBSITE_RUN_FROM_PACKAGE" = "",
    "FUNCTIONS_WORKER_RUNTIME" = "node",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key
  }
  os_type = "linux"
  version = "~3"
  storage_account_name = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key

  site_config {
    linux_fx_version          = "node|14"
    use_32_bit_worker_process = false
  }
  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"]
    ]
  }
}