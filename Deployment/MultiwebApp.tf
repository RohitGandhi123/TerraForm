#ResourceGroup

resource "azurerm_resource_group" "Master-QA" {
  name     = "CM-TRRA-QA-Master-RG"
  location = "North Central US"
}
#AppServicePlan

resource "azurerm_app_service_plan" "Master-QA-ASP" {
  name                = "CM-TRRA-QA-Master-Portala-ASPa"
  location            = "${azurerm_resource_group.Master-QA.location}"
  resource_group_name = "${azurerm_resource_group.Master-QA.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

#WebAppPortal

resource "azurerm_app_service" "Master-QA-WebPortal" {
  name                = "CM-TRRA-QA-Mastera-Portala"
  location            = "${azurerm_resource_group.Master-QA.location}"
  resource_group_name = "${azurerm_resource_group.Master-QA.name}"
  app_service_plan_id = "${azurerm_app_service_plan.Master-QA-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
