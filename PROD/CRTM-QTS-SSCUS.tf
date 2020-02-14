resource "azurerm_storage_account" "CRTM-QTS-STORAGE" {
  name                     = "crtmqtsfuncsscus"
  resource_group_name      = "CRTM-QTS-App-SSCUS-RG"
  location                 = "South Central US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "CRTM-QTS-FUNC-ASP" {
  name                = "CRTM-QTS-Func-APP-ASP-SSCUS"
  location            = "South Central US"
  resource_group_name = "CRTM-QTS-App-SSCUS-RG"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "CRTM-QTS-FUNC" {
  name                      = "CRTM-QTS-Func-APP-SSCUS"
  location                  = "South Central US"
  resource_group_name       = "CRTM-QTS-App-SSCUS-RG"
  app_service_plan_id       = azurerm_app_service_plan.CRTM-QTS-FUNC-ASP.id
  storage_connection_string = azurerm_storage_account.CRTM-QTS-STORAGE.primary_connection_string
}
