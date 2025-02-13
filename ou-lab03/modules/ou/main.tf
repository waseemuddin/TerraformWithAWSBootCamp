resource "aws_organizations_organizational_unit" "ou" {
  name      = var.ou_name
  parent_id = var.org_root_id
}

# output "ou_id" {
#   value = aws_organizations_organizational_unit.ou.id
# }