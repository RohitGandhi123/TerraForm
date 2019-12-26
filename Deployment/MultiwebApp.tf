variable "rg-names" {
  default = [
    "cm-drss-rg1",
    "cm-drss-rg2",
    "cm-drss-rg3
  ]
}

resource "azurerm_resource_group" "terraformresourcegp" {
    count               = 3
    name                = "${element(var.rg-names, count.index)}"
    locations           = "west us"
}
