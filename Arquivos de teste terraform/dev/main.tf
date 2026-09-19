terraform {
  backend "azurerm" {}
  required_version = ">= 1.8.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.79"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9e0045c4-9f26-4ee1-9d9b-591783536fb7"
}

module "api_core" {
  source               = "../../modules/api-core"
  location             = var.location
  postgres_location    = var.postgres_location
  unique_suffix        = var.unique_suffix
  github_client_id     = var.github_client_id
  github_client_secret = var.github_client_secret
}
