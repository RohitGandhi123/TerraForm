resource "azurerm_resource_group" "CM-Terraform-Test" {
  name     = "CM-Terraform-Test"
  location = "West Europe"
}

#AppServicePlan

resource "azurerm_app_service_plan" "ASP" {
  name                = "api-appserviceplan-procmsds"
  location            = azurerm_resource_group.CM-Terraform-Test.location
  resource_group_name = azurerm_resource_group.CM-Terraform-Test.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_provider_type" "CM-Terraform-WebApp" {
    count               = 3
    name                = "cosmeticname-count.index"
    location            = "${azurerm_resource_group.CM-Terraform-Test.location}"
    resource_group_name = "${azurerm_resource_group.CM-Terraform-Test.name}"
    tags                = "${azurerm_resource_group.CM-Terraform-Test.tags}"
    app_service_plan_id = "${azurerm_app_service_plan.ASP.id}"

    kind                = "Linux"
    sku {
        tier = "Free"
        size = "F1"
    }
}
