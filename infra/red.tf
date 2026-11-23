# ---------- Red ----------
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "SG del servidor web"
  tags        = local.etiquetas

  ingress {
    description = "SSH solo desde la red administrativa"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  ingress {
    description = "HTTPS desde la red interna"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "HTTPS de salida"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}
