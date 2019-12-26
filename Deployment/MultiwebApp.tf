variable "rg_name"                      { }
variable "location"                     { }
variable "tag_env"                      { }
variable "tag_role"                     { }
variable "tag_service"                  { }
variable "count_vm"                       { }
variable "create_vm_pip"                  { }

# Remote state data source, no interpolations allowed
terraform {
  backend "azurerm" {
    # TF state file to be stored remotely. terraform.tf state should remain the suffix
    key = "bug-prod-eastus.terraform.tfstate"

    # Default backend storage account for Terraform - DO NOT CHANGE
    storage_account_name = "asphaltthurs"
    
    # Default backend storage account for Terraform - DO NOT CHANGE
    container_name       = "terraform-state"
  }
}

# Configure TF provider: Microsoft Azure
provider "azurerm" {
  version         = "~> 0.1"
  subscription_id = "0ae78c52-da35-4145-af80-af727883a5d1"
  client_id       = "be5abe5d-98e4-4fb0-8b3b-058ee32344a0"   
  client_secret   = "c3501a68-8f57-4bcd-80f3-e3e3aa527dc8"
  tenant_id       = "332cf3d3-680b-476e-ad0a-659e90b87300"
}

resource "azurerm_resource_group" "bug_eastus" {
  name     = "${var.rg_name}"
  location = "${var.location}"
}

resource "azurerm_public_ip" "bug_eastus" {
  count                        = "${var.create_vm_pip ? var.count_vm : 0}"
  name                         = "${var.tag_service}0-${var.tag_env}-Pip"
  location                     = "${var.location}"
  resource_group_name          = "${var.rg_name}"
  public_ip_address_allocation = "dynamic"
}
