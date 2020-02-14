
#ResourceGroup

resource "azurerm_resource_group" "CRTM-MASTER" {
  name     = "CRTM-Masters-App-SNCUS-RG"
  location = "North Central US"
}

#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-MASTER-ASP" {
  name                = "CRTM-Masters-Portal-ASP-SNCUS"
  location            = "${azurerm_resource_group.CRTM-MASTER.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-MASTER.name}"

  sku {
    tier = "Premuim"
    size = "P1V2"
  }
}

#WebAppPortal

resource "azurerm_app_service" "CRTM-MASTER-PORTAL" {
  name                = "CRTM-MASTER-Portal-SNCUS"
  location            = "${azurerm_resource_group.CRTM-MASTER.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-MASTER.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-MASTER-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


#WebAppPortalAPI

resource "azurerm_app_service" "CRTM-MASTER-API" {
  name                = "CRTM-MASTER-API-SNCUS"
  location            = "${azurerm_resource_group.CRTM-MASTER.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-MASTER.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-MASTER-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}