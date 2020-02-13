#ResourceGroup

resource "azurerm_resource_group" "Master-QA" {
  name     = "CM-TRRA-QA-Master-RGasadsd"
  location = "North Central US"
}

#AppInsight

resource "azurerm_application_insights" "Master-QA-AppInsight" {
  name                = "CM-TRRA-QA-Master-APP-INSIGHTSasweqwesds"
  location            = "North Central US"
  resource_group_name = "${azurerm_resource_group.Master-QA.name}"
  application_type    = "web"
}
