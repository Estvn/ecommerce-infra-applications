# Configuración del Queue Storage de Azure
resource "azurerm_storage_account" "sa_queue" {
    name                     = "saqueue${lower(var.project_name)}${lower(var.enviroment)}"
    resource_group_name      = azurerm_resource_group.rg_ecommerce.name
    location                 = var.location
    
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags                      = var.tags
}

resource "azurerm_storage_queue" "qs" {
    name                 = "qs-${lower(var.project_name)}-${lower(var.enviroment)}"
    storage_account_name = azurerm_storage_account.sa_queue.name
}

# Configuración de Azure Functions 
resource "azurerm_storage_account" "sa_functions" {
    name                     = "safunctions${lower(var.project_name)}${lower(var.enviroment)}"
    resource_group_name      = azurerm_resource_group.rg_ecommerce.name
    location                 = var.location

    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
        
    tags                      = var.tags
}

resource "azurerm_service_plan" "sp_functions" {
    name                = "sp-functions-${lower(var.project_name)}-${lower(var.enviroment)}"
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    location            = var.location

    os_type             = "Linux"
    sku_name            = "B1"
    tags                = var.tags
}

resource "azurerm_linux_function_app" "fa" {
    name               = "fa-${lower(var.project_name)}-${lower(var.enviroment)}"
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    location           = var.location

    storage_account_name       = azurerm_storage_account.sa_functions.name
    storage_account_access_key = azurerm_storage_account.sa_functions.primary_access_key
    service_plan_id            = azurerm_service_plan.sp_functions.id

    tags                       = var.tags    
    site_config {}
}