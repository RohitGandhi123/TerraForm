
#ResourceGroup

resource "azurerm_resource_group" "CRTM-SHELL" {
  name     = "CRTM-Shell-App-SSCUS-RG"
  location = "South Central US"
}
#AppServicePlan

resource "azurerm_app_service_plan" "CRTM-SHELL-ASP" {
  name                = "CRTM-Shell-Portal-ASP-SSCUS"
  location            = "${azurerm_resource_group.CRTM-SHELL.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-SHELL.name}"

  sku {
    tier = "Premuim"
    size = "P1V2"
  }
}

#WebAppPortal

resource "azurerm_app_service" "CRTM-SHELL-PORTAL" {
  name                = "CRTM-Shell-Portal-SSCUS"
  location            = "${azurerm_resource_group.CRTM-SHELL.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-SHELL.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-SHELL-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


#WebAppPortalAPI

resource "azurerm_app_service" "CRTM-SHELL-API" {
  name                = "CRTM-Shell-API-SSCUS"
  location            = "${azurerm_resource_group.CRTM-SHELL.location}"
  resource_group_name = "${azurerm_resource_group.CRTM-SHELL.name}"
  app_service_plan_id = "${azurerm_app_service_plan.CRTM-SHELL-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}