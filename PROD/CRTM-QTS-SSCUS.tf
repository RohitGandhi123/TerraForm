resource "azurerm_storage_account" "CRTM-OTS-STORAGE" {
  name                     = "crtmotsfuncsscus"
  resource_group_name      = "CRTM-OTS-App-SSCUS-RG"
  location                 = "South Central US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "CRTM-OTS-FUNC-ASP" {
  name                = "CRTM-OTS-Func-APP-ASP-SSCUS"
  location            = "South Central US"
  resource_group_name = "CRTM-OTS-App-SSCUS-RG"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "CRTM-OTS-FUNC-APP" {
  name                      = "CRTM-OTS-Func-APP-SSCUS"
  location                  = "South Central US"
  resource_group_name       = "CRTM-OTS-App-SSCUS-RG"
  app_service_plan_id       = azurerm_app_service_plan.CRTM-OTS-FUNC-ASP.id
  storage_connection_string = azurerm_storage_account.CRTM-OTS-STORAGE.primary_connection_string
}
