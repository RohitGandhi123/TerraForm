resource "azurerm_resource_group" "webapps"{
    name               ="webapps"
    location           ="west us"
}

locals {
    webappsperlocs   = 3
}

resource "azurerm_app_service_plan" "ASP" {
    count               = "${length(var.webapplocs)}"
    name                = "plan-free-${var.webapplocs[count.index]}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    kind                = "Linux"
    reserved            = true
    sku {
        tier = "Free"
        size = "F1"
    }
}
