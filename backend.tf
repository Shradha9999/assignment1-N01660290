terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01660290RG"
    storage_account_name = "tfstaten01660290sa"
    container_name       = "tfstatefiles"
    key                  = "tfstate"
  }
}
