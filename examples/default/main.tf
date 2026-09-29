module "naming" {
  source  = "codectl/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "regions" {
  source  = "codectl/locations/azure"
  version = "~> 1.0"

  location = {
    primary = "westeurope"
  }
}

module "rg" {
  source  = "codectl/rg/azure"
  version = "~> 1.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = module.regions.location.primary.name
    }
  }
}

module "firewall" {
  source  = "codectl/fw/azure"
  version = "~> 1.0"

  firewall = {
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    name                = module.naming.firewall.name
    sku_name            = "AZFW_VNet"
    sku_tier            = "Standard"
  }
}
