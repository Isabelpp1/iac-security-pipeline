# Instancia EC2 con IMDSv1, disco sin cifrar e IP pública
resource "aws_instance" "web" {
  ami                         = "ami-0123456789abcdef0"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web.id]

  root_block_device {
    encrypted = false
  }
}
