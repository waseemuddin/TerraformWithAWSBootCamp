# resource "aws_organizations_organization" "org" {
#   feature_set = "ALL"
# }

# resource "aws_organizations_organizational_unit" "ou" {
#   name      = "example-ou"
#   parent_id = aws_organizations_organization.org.roots[0].id
# }

# resource "aws_organizations_account" "example_account" {
#   name      = "example-account"
#   email     = "cloudops.us@gmail.com"
#   parent_id = aws_organizations_organizational_unit.ou.id
#   role_name = "OrganizationAccousntAccessRole"
# }


data "aws_organizations_organization" "current" {}

resource "aws_organizations_organizational_unit" "ou" {
  name      = "example-ou"
  parent_id = data.aws_organizations_organization.current.roots[0].id
}

resource "aws_organizations_account" "example_account" {
  name      = "example-account"
  email     = "cloudops.us@gmail.com"
  parent_id = aws_organizations_organizational_unit.ou.id
  role_name = "OrganizationAccountAccessRole"
}