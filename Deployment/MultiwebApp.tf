#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-SHELL-ASP" {
  name                = "CRTM-Shell-Portal-ASP-SNCUS"
  location            = "North Central US"
  resource_group_name = "Test"

  sku {
    tier = "Premium"
    size = "P1V2"
  }
}

#WebAppPortal

resource "azurerm_app_service" "CRTM-SHELL-PORTAL" {
  name                = "CRTM-Shell-Portal-SNCUS"
  location            = "North Central US"
  resource_group_name = "CRTM-Shell-App-SNCUS-RG"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-SHELL-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
  }
}
