# Base de datos pública, sin cifrado y sin backups
resource "aws_db_instance" "db" {
  identifier          = "demo-db"
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  username            = "admin"
  password            = "Password123!"
  publicly_accessible = true
  storage_encrypted   = false
  skip_final_snapshot = true
  backup_retention_period = 0
}
