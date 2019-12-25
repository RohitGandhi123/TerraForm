resource "azurerm_resource_group" "terraformresourcegp" {
    count               = 3
    name                = "cosmeticname-count.index"
    location = "West Europe"
}
