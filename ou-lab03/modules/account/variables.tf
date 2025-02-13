variable "account_email" {
  description = "The email address for the new AWS account"
  type        = string
}

variable "account_name" {
  description = "The name for the new AWS account"
  type        = string
}

variable "parent_id" {
  description = "The parent ID (OU or root) for the new AWS account"
  type        = string
}

