#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-SHELL-ASP" {
  name                = "CRTM-Shell-Portal-ASPAS-SNCUS"
  location            = "North Central US"
  resource_group_name = "CM-TRRA-QA-Master-RGasadsd"

  sku {
    tier = "Premium"
    size = "P1V2"
  }
}
