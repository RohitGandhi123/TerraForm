resource "azurerm_resource_group" "CM-Terraform-Test" {
  name     = "CM-Terraform-Test"
  location = "West Europe"
}

resource "azurerm_application_insights" "Ap" {
  name                = "tf-test-appinsights"
  location            = "West Europe"
  resource_group_name = "${azurerm_resource_group.CM-Terraform-Test.name}"
  application_type    = "web"
}

output "instrumentation_key" {
  value = "${azurerm_application_insights.Ap.instrumentation_key}"
}

output "app_id" {
  value = "${azurerm_application_insights.Ap.app_id}"
}

#AppServicePlan

resource "azurerm_app_service_plan" "example" {
  name                = "api-appserviceplan-procmsds"
  location            = azurerm_resource_group.CM-Terraform-Test.location
  resource_group_name = azurerm_resource_group.CM-Terraform-Test.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

#StorageAcccoun

resource "azurerm_storage_account" "Storage" {
  name                     = "cmtrstorageaccqwcx"
  resource_group_name      = "${azurerm_resource_group.CM-Terraform-Test.name}"
  location                 = "${azurerm_resource_group.CM-Terraform-Test.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

#FunctionApp

resource "azurerm_app_service_plan" "FunctionApp" {
  name                = "api-appserviceplan-pro"
  location            = azurerm_resource_group.CM-Terraform-Test.location
  resource_group_name = azurerm_resource_group.CM-Terraform-Test.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
