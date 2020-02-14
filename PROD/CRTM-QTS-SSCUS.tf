#ResourceGroup

resource "azurerm_resource_group" "CRTM-QTS" {
  name     = "CRTM-QTS-App-SSCUS-RG"
  location = "South Central US"
}
#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-QTS-ASP" {
  name                = "CRTM-QTS-Portal-ASP-SSCUS"
  location            = azurerm_resource_group.CRTM-QTS.location
  resource_group_name = azurerm_resource_group.CRTM-QTS.name

  sku {
    tier = "Premuim"
    size = "P1V2"
  }
}

#WebAppPortal

resource "azurerm_app_service" "CRTM-QTS-PORTAL" {
  name                = "CRTM-QTS-Portal-SSCUS"
  location            = azurerm_resource_group.CRTM-QTS.location
  resource_group_name = azurerm_resource_group.CRTM-QTS.name
  app_service_plan_id = azurerm_app_service_plan.CRTM-QTS-ASP.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


#WebAppPortalAPI

resource "azurerm_app_service" "CRTM-QTS-API" {
  name                = "CRTM-QTS-API-SSCUS"
  location            = azurerm_resource_group.CRTM-QTS.location
  resource_group_name = azurerm_resource_group.CRTM-QTS.name
  app_service_plan_id = azurerm_app_service_plan.CRTM-QTS-ASP.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
