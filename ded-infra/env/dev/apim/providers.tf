terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.62.1"
    }
  }
}
provider "azurerm" {
     features {} 
     }