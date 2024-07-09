provider "azurerm" {
features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.104.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resource-group"
  location = "East US"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shradha.Gopi"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "rgroup-N01660290" {
  source = "./modules/rgroup-N01660290"

  name     = "N01660290-RG"
  location = "East US"
}

module "network-N01660290" {
  source                  = "./modules/network-N01660290"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  prefix                  = "N01660290"
  address_space           = ["10.0.0.0/16"]
  subnet_name             = "N01660290-SUBNET"
  vnet_name               = "N01660290-VNET"
  subnet_address_prefixes = ["10.0.1.0/24"]
  nsg_name                = "N01660290-NSG"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shradha.Gopi"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "common-N01660290" {
  source = "./modules/common-N01660290"

  resource_group_name = module.rgroup-N01660290.resource_group_name
  location            = "East US"
  prefix              = "N01660290"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shradha.Gopi"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "vmlinux-N01660290" {
  source = "./modules/vmlinux-N01660290"

  resource_group_name          = module.rgroup-N01660290.resource_group_name
  location                     = "East US"
  subnet_id                    = module.network-N01660290.subnet_id
  vm_names                     = ["N01660290-vm1", "N01660290-vm2", "N01660290-vm3"]
  admin_username               = "azureuser"
  admin_password               = "P@ssw0rd123!"
  boot_diagnostics_storage_uri = module.common-N01660290.storage_account_uri
  tags                         = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shradha.Gopi"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
  dns_domain_name              = "example.com"  # Replace with your actual DNS domain name
}

module "vmwindows-N01660290" {
  source = "./modules/vmwindows-N01660290"

  resource_group_name          = module.rgroup-N01660290.resource_group_name
  location                     = "East US"
  subnet_id                    = module.network-N01660290.subnet_id
  admin_username               = "azureuser"
  admin_password               = "P@ssw0rd123!"
  boot_diagnostics_storage_uri = module.common-N01660290.storage_account_uri
  dns_domain_name              = "example.com"  # Replace with your actual DNS domain name
  prefix                       = "N01660290"
  vm_count                     = 1  # Number of VM instances to create
  nsg_id                       = module.network-N01660290.nsg_id  # Replace with actual NSG ID
  tags                         = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shradha.Gopi"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "datadisk-N01660290" {
  source              = "./modules/datadisk-N01660290"
  prefix              = "N01660290"
  location            = "East US"
  resource_group_name = module.rgroup-N01660290.resource_group_name
  vm_ids              = module.vmlinux-N01660290.vm_ids
}

module "loadbalancer-N01660290" {
  source = "./modules/loadbalancer-N01660290"

  prefix              = "N01660290"
  location            = "East US"
  resource_group_name = module.rgroup-N01660290.resource_group_name
}

module "database-N01660290" {
  source              = "./modules/database-N01660290"
  prefix              = "N01660290"
  database_name       = "N01660290-db"
  location            = "East US"
  resource_group_name = module.rgroup-N01660290.resource_group_name
  admin_username      = "dbadmin"
  admin_password      = "P@ssw0rd123!"
  tags                = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shradha.Gopi"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
