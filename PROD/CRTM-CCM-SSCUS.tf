
#ResourceGroup

resource "azurerm_resource_group" "CRTM-CCM" {
  name     = "CRTM-CCM-App-SSCUS-RG"
  location = "South Central US"
}

#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-CCM-ASP" {
  name                = "CRTM-CCM-Portal-ASP-SSCUS"
  location            = "${azurerm_resource_group.CRTM-CCM.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-CCM.name}"

  sku {
    tier = "Premuim"
    size = "P1V2"
  }
}

#WebAppPortal

resource "azurerm_app_service" "CRTM-CCM-PORTAL" {
  name                = "CRTM-CCM-Portal-SSCUS"
  location            = "${azurerm_resource_group.CRTM-CCM.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-CCM.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-CCM-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


#WebAppPortalAPI

resource "azurerm_app_service" "CRTM-CCM-API" {
  name                = "CRTM-CCM-API-SSCUS"
  location            = "${azurerm_resource_group.CRTM-CCM.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-CCM.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-CCM-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}