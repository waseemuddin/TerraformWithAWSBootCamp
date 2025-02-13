//*****EFS TF Resource Script *****/

resource "aws_efs_file_system" "efs" {
  creation_token = var.creation_token
  encrypted      = true
  tags = {
  Name = var.efs_name
  }
}
resource "aws_efs_mount_target" "efs_mt" {
  count           = length(var.subnets)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnets[count.index]
  security_groups = [var.efs_sg_id]
}

