
#ResourceGroup

resource "azurerm_resource_group" "CRTM-OTS" {
  name     = "CRTM-OTS-App-SSCUS-RG"
  location = "North Central US"
}
#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-OTS-ASP" {
  name                = "CRTM-OTS-Portal-ASP-SSCUS"
  location            = "${azurerm_resource_group.CRTM-OTS.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-OTS.name}"

  sku {
    tier = "Premuim"
    size = "P1V2"
  }
}

#WebAppPortal

resource "azurerm_app_service" "CRTM-OTS-PORTAL" {
  name                = "CRTM-OTS-Portal-SSCUS"
  location            = "${azurerm_resource_group.CRTM-OTS.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-OTS.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-OTS-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


#WebAppPortalAPI

resource "azurerm_app_service" "CRTM-OTS-API" {
  name                = "CRTM-OTS-API-SSCUS"
  location            = "${azurerm_resource_group.CRTM-OTS.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-OTS.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-OTS-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


resource "azurerm_storage_account" "CRTM-OTS-STORAGE" {
  name                     = "crtmotsfuncsscus"
  resource_group_name      = azurerm_resource_group.CRTM-OTS.name
  location                 = azurerm_resource_group.CRTM-OTS.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "CRTM-OTS-FUNC-ASP" {
  name                = "CRTM-OTS-Func-APP-ASP-SSCUS"
  location            = azurerm_resource_group.CRTM-OTS.location
  resource_group_name = azurerm_resource_group.CRTM-OTS.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "CRTM-OTS-FUNC-APP" {
  name                      = "CRTM-OTS-Func-APP-SSCUS"
  location                  = azurerm_resource_group.CRTM-OTS.location
  resource_group_name       = azurerm_resource_group.CRTM-OTS.name
  app_service_plan_id       = azurerm_app_service_plan.CRTM-OTS-FUNC-ASP.id
  storage_connection_string = azurerm_storage_account.CRTM-OTS-STORAGE.primary_connection_string
}