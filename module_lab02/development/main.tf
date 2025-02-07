
provider "aws" {
    region = var.aws_region
}


# terraform {
#     backend "s3" {
#       bucket = "fui-infra"
#       key = "fui-infra.tfstate"
#       region = "us-east-1"
#     }
    
# }
