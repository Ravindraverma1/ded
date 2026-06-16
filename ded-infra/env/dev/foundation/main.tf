module "foundation" {
  source = "../../../modules/foundation"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  law_name           = var.law_name
  law_sku            = var.law_sku
  law_retention_days = var.law_retention_days
}