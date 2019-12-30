#ResourceGroup

resource "azurerm_resource_group" "Master-QA" {
  name     = "CM-TRRA-QA-MASTER-RG1"
  location = "North Central US"
}

#AppInsight

resource "azurerm_application_insights" "Master-QA-AppInsight" {
  name                = "CM-TRRA-QA-Master-APP-INSIGHTS"
  location            = "North Central US"
  resource_group_name = "${azurerm_resource_group.Master-QA.name}"
  application_type    = "web"
}

#Storage

resource "azurerm_storage_account" "Master-Qa-Storage" {
  name                     = "cmtrrarmasterqa"
  resource_group_name      = "${azurerm_resource_group.Master-QA.name}"
  location                 = "${azurerm_resource_group.Master-QA.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

#Redis Cache


# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "Master-QA-Redis" {
  name                = "CM-TRRA-QA-Master-RDS"
  location            = "${azurerm_resource_group.Master-QA.location}"
  resource_group_name = "${azurerm_resource_group.Master-QA.name}"
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {}
}

#AppServicePlan

resource "azurerm_app_service_plan" "Master-QA-ASP" {
  name                = "CM-TRRA-QA-Master-Portal-ASP"
  location            = "${azurerm_resource_group.Master-QA.location}"
  resource_group_name = "${azurerm_resource_group.Master-QA.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

#WebAppPortal

resource "azurerm_app_service" "Master-QA-WebPortal" {
  name                = "CM-TRRA-QA-Master-Portal"
  location            = "${azurerm_resource_group.Master-QA.location}"
  resource_group_name = "${azurerm_resource_group.Master-QA.name}"
  app_service_plan_id = "${azurerm_app_service_plan.Master-QA-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}

#WebAppAPI

resource "azurerm_app_service" "Master-QA-WebAPI" {
  name                = "CM-TRRA-QA-Master-API"
  location            = "${azurerm_resource_group.Master-QA.location}"
  resource_group_name = "${azurerm_resource_group.Master-QA.name}"
  app_service_plan_id = "${azurerm_app_service_plan.Master-QA-ASP.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
