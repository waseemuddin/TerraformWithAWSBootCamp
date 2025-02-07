//***** SG TF Resource Script *****/

locals {
  from_in = [22,443,8080]
  port_out = [22,443,80,8080,3389]
}
resource "aws_security_group" "myapp-efs-sg" {
    name = var.vpc_name
    description = "Allow all inbound rules"
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
        for_each = toset(local.port_out)
        content {
            from_port = egress.value
            to_port = egress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]

        }

    }
    tags = {
        Name: "${var.vpc_name}-allow-all"

    }
    

}

resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Allow NFS traffic from EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.myapp-efs-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}