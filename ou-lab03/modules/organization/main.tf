data "aws_organizations_organization" "current" {} 
// This is current organization account id like root account

resource "aws_iam_policy" "org_policy" {
  name        = "OrganizationPolicy"
  description = "IAM policy for managing AWS Organization"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["organizations:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# output "organization_id" {
#   value = data.aws_organizations_organization.current.id
# }

# output "root_id" {
#   value = data.aws_organizations_organization.current.roots[0].id
# }