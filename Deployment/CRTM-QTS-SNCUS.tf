
#ResourceGroup

resource "azurerm_resource_group" "CRTM-QTS" {
  name     = "CRTM-QTS-App-SNCUS-RG"
  location = "North Central US"
}
#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-QTS-ASP" {
  name                = "CRTM-QTS-Portal-ASP-SNCUS"
  location            = "${azurerm_resource_group.CRTM-QTS.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-QTS.name}"

  sku {
    tier = "Premuim"
    size = "P1V2"
  }
}

#WebAppPortal

resource "azurerm_app_service" "CRTM-QTS-PORTAL" {
  name                = "CRTM-QTS-Portal-SNCUS"
  location            = "${azurerm_resource_group.CRTM-QTS.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-QTS.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-QTS-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


#WebAppPortalAPI

resource "azurerm_app_service" "CRTM-QTS-API" {
  name                = "CRTM-QTS-API-SNCUS"
  location            = "${azurerm_resource_group.CRTM-QTS.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-QTS.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-QTS-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


resource "azurerm_storage_account" "CRTM-QTS-STORAGE" {
  name                     = "crtmqtsfunc"
  resource_group_name      = azurerm_resource_group.CRTM-QTS.name
  location                 = azurerm_resource_group.CRTM-QTS.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "CRTM-QTS-FUNC-ASP" {
  name                = "CRTM-QTS-Func-APP-ASP"
  location            = azurerm_resource_group.CRTM-QTS.location
  resource_group_name = azurerm_resource_group.CRTM-QTS.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "CRTM-QTS-FUNC" {
  name                      = "CRTM-QTS-Func-APP"
  location                  = azurerm_resource_group.CRTM-QTS.location
  resource_group_name       = azurerm_resource_group.CRTM-QTS.name
  app_service_plan_id       = azurerm_app_service_plan.CRTM-QTS-FUNC-ASP.id
  storage_connection_string = azurerm_storage_account.CRTM-QTS-STORAGE.primary_connection_string
}