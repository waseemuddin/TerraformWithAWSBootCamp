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


### Topics to be added in Terraform Repo
```shell
Introduction to Terraform and Cloud-Native Tools.
Cloud-Native Tools vs. Terraform: Comparison of disadvantages.
Understanding Terraform’s provider block.
Tutorial on installing Terraform.
Setting up an initial Terraform configuration with AWS provider.
Creating AWS resources: VPC, Internet Gateway, and Subnets.
Security Groups: Configuring inbound and outbound rules.
Data Sources: Accessing resources created outside Terraform.
Practical example with remote Terraform state.
Creating EC2 instances with remote state files.
Using data sources to access networking components in Terraform.
Nested dependencies and deploying EC2 with data sources.
Moving to Day 2: Introduction to advanced Terraform topics.
Dependencies in Terraform: Implicit and explicit dependencies.
Variables and tfvars files for modular configurations.
Practical example: Organizing variables in tfvars.
Advanced Terraform configurations: Using prevent_destroy and create_before_destroy.
Managing state files and Terraform workspaces.
Introduction to Terraform modules and modularization.
Practical example: Creating reusable modules.
Module outputs and passing data between modules.
Using count and for_each in modules.
Provider configurations in modules.
Advanced usage of locals for DRY code.
Environment-based configuration with workspaces.
Dynamic blocks and their use cases.
Handling sensitive data with terraform.tfvars.
Working with remote backends in production environments.
Terraform state locking and avoiding conflicts.
Automated testing with Terraform: Overview of tools and methods.
 ontinuous Integration (CI) pipelines with Terraform.
Integrating Terraform with GitHub Actions.
Error handling and debugging in complex Terraform scripts.
Best practices for structuring Terraform projects.
Importing existing infrastructure into Terraform.
Terraform’s lifecycle rules (create_before_destroy, prevent_destroy).
 Handling multi-cloud deployments with Terraform.
Overview of HashiCorp’s Terraform Cloud.
Managing team access and roles in Terraform Cloud.
End-to-end workflow example: Multi-environment setup.
Wrapping up: Key takeaways and advanced tips for Terraform users.
```