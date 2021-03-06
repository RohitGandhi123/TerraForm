resource "azurerm_resource_group" "example" {
  name     = "tf-test"
  location = "West Europe"
}

resource "azurerm_application_insights" "example" {
  name                = "tf-test-appinsights"
  location            = "West Europe"
  resource_group_name = "${azurerm_resource_group.example.name}"
  application_type    = "web"
}

output "instrumentation_key" {
  value = "${azurerm_application_insights.example.instrumentation_key}"
}

output "app_id" {
  value = "${azurerm_application_insights.example.app_id}"
}