# PR de prueba: abre SSH a todo internet A PROPÓSITO para demostrar el gate.
# Este PR debe quedar BLOQUEADO y cerrarse sin fusionar.
resource "aws_security_group" "bastion" {
  name        = "bastion-sg"
  description = "SG del bastion"
  tags = {
    Proyecto    = "demo-iac"
    Ambiente    = "dev"
    Responsable = "equipo-seguridad"
  }

  ingress {
    description = "SSH abierto a internet (inseguro)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
