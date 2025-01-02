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
$ terraform state
$ terraform state list
$ terraform state show aws_subnet.mynetwork_subnet-1
$ terraform state show aws_subnet.mynetwork_subnet-2

```


```shell
// How to define Terraform Validable  -  There are 3 ways to define terrafrom variables
$ 1 - terraform apply 
var.subnet_cidr_block
  subnet cidr block - 1

  Enter a value: 192.168.1.0/25

$ 2 - terraform apply -var "subnet_cidr_block=192.168.1.0/25"

(3rd way is to define in seperate file such as "terraform.tfvars" and use below line)
$ 3 - subnet_cidr_block = "192.168.1.0/25" 

```

