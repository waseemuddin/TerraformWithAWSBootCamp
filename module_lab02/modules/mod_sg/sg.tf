
locals {
  ports_in = [443,80,22]
  ports_out = [22,3389,80,443,8080]
}



resource "aws_security_group" "myapp-sg" {
    name = var.vpc_name //optional
    description = "Allow all inbound traffic" //optional
    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = var.service_ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        for_each = toset(local.ports_out)
        content {
            from_port = egress.value
            to_port = egress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    tags = {
        Name: "${var.vpc_name}-sg-all"
        enviornment: "${var.enviornment}"
    }

}

