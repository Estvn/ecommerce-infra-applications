variable "subscription_id" {
    type        = string
    description = "My Azure ID student subscription"
}

variable "location" {
    type        = string
    description = "Services' location"
    default     = "Central US"
}

variable "tags" {
    type        = map(string)
    description = "Services' tags"
    default = {
        enviroment = "development"
        date       = "2025-06-20"
        createdBy  = "Estiven Mejía"
    }
}

variable "project_name" {
    type        = string
    description = "project´s name"
    default     = "ecommerce"
}

variable "enviroment" {
    type        = string
    description = "enviroment´s project"
    default     = "env"
}

