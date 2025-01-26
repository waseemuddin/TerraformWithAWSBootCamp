## In this file we will define the variables

variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "key_name" {}
variable "public_cidr_block" {}
variable "private_cidr_block" {}
variable "avail_zone" {}
variable "environments" {}
variable "ingress_service" {
  type        = list(number)
  description = "List of ingress ports for the security group"
  default     = [80, 8080, 443, 22, 3306, 1900, 1443]
}
