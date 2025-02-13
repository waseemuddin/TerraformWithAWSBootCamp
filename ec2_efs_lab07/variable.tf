//*****Terraform Variables *****/
variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "avail_zone" {}
variable "public_subnets" {}
variable "aws_region" {}
variable "image_name" {}



# Let say Customer has a web app which is build on load balancer
# envionment and we have to store logs in a cernteralize location.
# so we use the approch amazon EFS for logginng allication logs from the 
# load balancer servers. Also to design this scanaior we use IaC Terrafrom wit complete moduler approvch
# lets do this and here is complete guide.
