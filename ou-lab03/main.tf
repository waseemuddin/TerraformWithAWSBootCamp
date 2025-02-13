module "organization" {
  source = "./modules/organization"
}

module "ou" {
  source    = "./modules/ou"
  org_root_id = module.organization.root_id
  ou_name   = var.ou_name
}

module "account" {
  source    = "./modules/account"
  parent_id = module.ou.ou_id
  account_name = var.account_name
  account_email = var.account_email
}


