#ResourceGroup

resource "azurerm_resource_group" "CRTM-OTS" {
  name     = "CRTM-OTS-App-SNCUS-RG"
  location = "North Central US"
}
#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-OTS-ASP" {
  name                = "CRTM-OTS-Portal-ASP-SNCUS"
  location            = "${azurerm_resource_group.CRTM-OTS.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-OTS.name}"

  sku {
    tier = "Premuim"
    size = "P1V2"
  }
}

#WebAppPortal

resource "azurerm_app_service" "CRTM-OTS-PORTAL" {
  name                = "CRTM-OTS-Portal-SNCUS"
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
  name                = "CRTM-OTS-API-SNCUS"
  location            = "${azurerm_resource_group.CRTM-OTS.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-OTS.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-OTS-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
