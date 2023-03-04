module "resource_group" {
  source      = "../tf-modules/Resource-groups"
  rg_location = "eastus"
  rg_name     = "titaniam-rg"
  tags = {
    CreatedBy = "Mukul"
  }
}