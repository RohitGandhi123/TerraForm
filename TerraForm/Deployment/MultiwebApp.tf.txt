resource "azurerm_app_service" "webApp" {

    count               = "${var.instance_count}"
    name                = "CM-Tf-test-webapp"
    location            = "${azurerm_resource_group.CM-Terraform-Test.location}"
    resource_group_name = "${azurerm_resource_group.CM-Terraform-Test.name}"
    app_service_plan_id = "${azurerm_app_service_plan.ASP.id}"

    tags = {
    Name  = "${element(var.instance_tags, count.index)}"
    Batch = "5AM"
    }

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

