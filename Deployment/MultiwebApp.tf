locals {
    locations     = [ "eastus2", "uksouth", "centralindia" ]
    default_prefix  = "rg-${var.tags["env"]}"
    app_prefix      = "${var.app_prefix != "" ? var.app_prefix : local.default_prefix}"
}

resource "azurerm_resource_group" "terraformresourcegp" {
    count               = "${length(local.locations)}"
    name                = "${format("%s-%s-%s", local.app_prefix, random_string.webapprnd.result, local.locations[count.index])}"
    location            = "${local.locations[count.index]}"
}
