resource "azurerm_resource_group" "CM-Terraform-Test" {
  name     = "CM-Terraform-Test"
  location = "West Europe"
}

resource "azurerm_application_insights" "example" {
  name                = "tf-test-appinsights"
  location            = "West Europe"
  resource_group_name = "${azurerm_resource_group.CM-Terraform-Test.name}"
  application_type    = "web"
}

output "instrumentation_key" {
  value = "${azurerm_application_insights.example.instrumentation_key}"
}

output "app_id" {
  value = "${azurerm_application_insights.example.app_id}"
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

#StorageAcccount

resource "azurerm_resource_group" "Storage" {
  name     = "example-resourcescvgfhnbjy"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = "${azurerm_resource_group.Storage.name}"
  location                 = "${azurerm_resource_group.Storage.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

#FunctionApp

resource "azurerm_app_service_plan" "example" {
  name                = "api-appserviceplan-pro"
  location            = azurerm_resource_group.CM-Terraform-Test.location
  resource_group_name = azurerm_resource_group.CM-Terraform-Test.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
