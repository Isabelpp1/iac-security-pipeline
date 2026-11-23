# Infraestructura de DEMO (versión corregida). Nada se despliega.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  etiquetas = {
    Proyecto    = "demo-iac"
    Ambiente    = "dev"
    Responsable = "equipo-seguridad"
  }
}

resource "aws_kms_key" "principal" {
  description         = "Llave KMS para cifrar datos de la demo"
  enable_key_rotation = true
  tags                = local.etiquetas

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AdministracionDeLaCuenta"
      Effect    = "Allow"
      Principal = { AWS = "arn:aws:iam::111122223333:root" }
      Action    = "kms:*"
      Resource  = "*"
    }]
  })
}
