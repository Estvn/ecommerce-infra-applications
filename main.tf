# Definición del proveedor de servicios
provider "azurerm" {
    subscription_id = var.subscription_id
    features {}
}

# Creación del grupo de recursos
resource "azurerm_resource_group" "rg_ecommerce" {
    name     = "rg-${lower(var.project_name)}-${lower(var.enviroment)}"
    location = var.location
    tags     = var.tags
}
