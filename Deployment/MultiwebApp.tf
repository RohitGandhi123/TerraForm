resource "azurerm_resource_group" "terraformresourcegp" {
    count               = 3
    name                = ${var.name[count.index]}"
    locations           = "west us"
}
