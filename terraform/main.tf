terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.44.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli = false   
}


resource "azurerm_resource_group" "this" {
  name = "test-rg"
  location = "northeurope"
}

resource "azurerm_resource_group" "this2" {
  name = "test-rg2"
  location = "northeurope"
}
