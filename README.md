# TerraformWithAWSBootCamp
This is terraform example

### Terrafrom Commands

// This commands shows the terrafrom version

```shell
// This commands shows the terrafrom version
$ Terraform -v 

// This command will check the terraform code or shows error or success
$ Terraform validate

// This command displays the preview about what going to perform
$ Terraform plan

// Apply command will execute and create the infra on Cloud 
$ Terraform apply

// Destroy command will destroy the infra everything you have created 
$ Terraform destroy

//this command will delete the particular subnet
$ Terraform destroy -target aws_subnet.mynetwork_subnet-2
 
$ terraform apply -auto-approve // this command with auto apply without confirming
$  
```