


resource "azurerm_app_service_plan" "example" {
  name                = "CRTM-OTS-Portal-ASP-SSCUS"
  location            =  South Central US
  resource_group_name = CRTM-OTS-App-SSCUS-RG

  sku {
    tier = "Premium"
    size = "P1V2"
  }
}

resource "azurerm_app_service" "example_sd" {
  name                = "CRTM-OTS-Portal-SSCUS"
  location            = South Central US
  resource_group_name = CRTM-OTS-App-SSCUS-RG
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}

resource "azurerm_app_service" "example_ad" {
  name                = "CRTM-OTS-API-SSCUS"
  location            = South Central US
  resource_group_name = CRTM-OTS-App-SSCUS-RG
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
 }
