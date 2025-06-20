# Service Plan y Web App para el Front Office
resource "azurerm_service_plan" "sp_front_office" {
    name                = "sp-front-office-${lower(var.project_name)}-${lower(var.enviroment)}"
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    location            = var.location

    os_type             = "Linux"
    sku_name            = "B1"
    tags                = var.tags
}

resource "azurerm_linux_web_app" "webapp_ui_front_office" {

    name                = "ui-front-office-${lower(var.project_name)}-${lower(var.enviroment)}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    service_plan_id     = azurerm_service_plan.sp_front_office.id

    site_config {
        always_on = true

        application_stack {
            docker_registry_url = "https://index.docker.io"
            docker_image_name   = "nginx:latest"
        }
    }

    app_settings = {
        WEBSITES_PORT = "80"
    }

    tags = var.tags
}

# Service Plan y Web App para el Back Office
resource "azurerm_service_plan" "sp_back_office" {
    name                = "sp-back-office-${lower(var.project_name)}-${lower(var.enviroment)}"
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    location            = var.location

    os_type             = "Linux"
    sku_name            = "B1"
    tags                = var.tags
}

resource "azurerm_linux_web_app" "webapp_ui_back_office" {

    name                = "ui-back-office-${lower(var.project_name)}-${lower(var.enviroment)}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    service_plan_id     = azurerm_service_plan.sp_back_office.id

    site_config {
        always_on = true

        application_stack {
            docker_registry_url = "https://index.docker.io"
            docker_image_name   = "nginx:latest"
        }
    }

    app_settings = {
        WEBSITES_PORT = "80"
    }

    tags = var.tags
}

# Service Plan y Web App para la API
resource "azurerm_service_plan" "sp_api" {
    name                = "sp-api-${lower(var.project_name)}-${lower(var.enviroment)}"
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    location            = var.location

    os_type             = "Linux"
    sku_name            = "B1"
    tags                = var.tags
}

resource "azurerm_linux_web_app" "webapp_api" {

    name                = "webapp-api-${lower(var.project_name)}-${lower(var.enviroment)}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg_ecommerce.name
    service_plan_id     = azurerm_service_plan.sp_api.id

    site_config {
        always_on = true

        application_stack {
            docker_registry_url = "https://index.docker.io"
            docker_image_name   = "nginx:latest"
        }
    }

    app_settings = {
        WEBSITES_PORT = "80"
    }

    tags = var.tags
}