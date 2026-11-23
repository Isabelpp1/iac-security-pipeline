# ---------- EC2 ----------
resource "aws_iam_role" "ec2" {
  name = "rol-ec2-demo"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
  tags = local.etiquetas
}

resource "aws_iam_instance_profile" "ec2" {
  name = "perfil-ec2-demo"
  role = aws_iam_role.ec2.name
}

resource "aws_instance" "web" {
  ami                         = "ami-0123456789abcdef0"
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.web.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  ebs_optimized               = true
  monitoring                  = true
  tags                        = local.etiquetas

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }
}
