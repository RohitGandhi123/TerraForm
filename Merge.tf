#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-Test" {
  name                = "CRTM-Shell-Portal-ASP-SNCUS"
  location            = "${Test.location}"
  resource_group_name = "${Test.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}
