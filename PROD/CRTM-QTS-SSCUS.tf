#ApplicationInsight

resource "azurerm_application_insights" "CCM-AppInsight" {
  name                = "CM-TRRA-CCM-QA-INST"
  location            = "North Central US"
  resource_group_name = "CM-TRRA-QA-CCM-RG"
  application_type    = "web"
}

#AppServicePlan

resource "azurerm_app_service_plan" "CCM-QA-ASP" {
  name                = "CM-TRRA-QA-CCM-Portal-ASP"
  location            = "North Central US"
  resource_group_name = "CM-TRRA-QA-CCM-RG"

  sku {
    tier = "Premuim"
    size = "S1"
  }
}
