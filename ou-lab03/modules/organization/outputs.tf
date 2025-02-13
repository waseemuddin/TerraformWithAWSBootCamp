output "organization_id" {
  value = data.aws_organizations_organization.current.id
}

output "root_id" {
  value = data.aws_organizations_organization.current.roots[0].id
}

// call the current account id

