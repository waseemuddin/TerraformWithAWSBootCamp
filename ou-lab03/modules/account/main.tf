resource "aws_organizations_account" "example_account" {
  name      = var.account_name
  email     = var.account_email
  parent_id = var.parent_id
  role_name = "OrganizationAccountAccessRole"
}

# output "account_id" {
#   value = aws_organizations_account.example_account.id
# }


