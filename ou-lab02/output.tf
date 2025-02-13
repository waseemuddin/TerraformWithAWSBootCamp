# output "organization_id" {
#   value = aws_organizations_organization.org.id
# }

# output "ou_id" {
#   value = aws_organizations_organizational_unit.ou.id
# }

# output "account_id" {
#   value = aws_organizations_account.example_account.id
# }


output "organization_id" {
  value = data.aws_organizations_organization.current.id
}

output "ou_id" {
  value = aws_organizations_organizational_unit.ou.id
}

output "account_id" {
  value = aws_organizations_account.example_account.id
}