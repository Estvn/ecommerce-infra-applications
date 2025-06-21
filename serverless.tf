# Creando un Storage Account para Azure Functions y Queue Storage
resource "azurerm_storage_account" "sa_serverless" {
    name                     = "saserverless${lower(var.project_name)}${lower(var.enviroment)}"
    resource_group_name      = azurerm_resource_group.rg_ecommerce.name
    location                 = var.location
    
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags                      = var.tags
}

# Creando el Queue Storage
resource "azurerm_storage_queue" "queue" {
    name                 = "queue-${lower(var.project_name)}-${lower(var.enviroment)}"
    storage_account_name = azurerm_storage_account.sa_serverless.name
}

# Creando un Service Plan para Azure Functions
resource "azurerm_service_plan" "sp_serverless" {
    name                = "sp-serverless-${lower(var.project_name)}-${lower(var.enviroment)}"
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    location            = var.location

    os_type             = "Linux"
    sku_name            = "B1"
    tags                = var.tags
}

# Creando una Azure Function
# Azure Functions comparte el mismo Storage Account que el Queue Storage
resource "azurerm_linux_function_app" "fa_serveless" {
    name               = "fa-serverless-${lower(var.project_name)}-${lower(var.enviroment)}"
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    location           = var.location

    storage_account_name       = azurerm_storage_account.sa_serverless.name
    storage_account_access_key = azurerm_storage_account.sa_serverless.primary_access_key
    service_plan_id            = azurerm_service_plan.sp_serverless.id

    tags                       = var.tags    
    site_config {}
}