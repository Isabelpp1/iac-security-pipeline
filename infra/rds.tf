# ---------- RDS ----------
resource "aws_iam_role" "rds_monitoring" {
  name = "rol-rds-monitoring-demo"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "monitoring.rds.amazonaws.com" }
    }]
  })
  tags = local.etiquetas
}

resource "aws_db_instance" "db" {
  identifier                          = "demo-db"
  engine                              = "mysql"
  instance_class                      = "db.t3.micro"
  allocated_storage                   = 20
  username                            = "admin"
  manage_master_user_password         = true
  publicly_accessible                 = false
  storage_encrypted                   = true
  kms_key_id                          = aws_kms_key.principal.arn
  skip_final_snapshot                 = false
  backup_retention_period             = 7
  deletion_protection                 = true
  multi_az                            = true
  monitoring_interval                 = 60
  monitoring_role_arn                 = aws_iam_role.rds_monitoring.arn
  auto_minor_version_upgrade          = true
  enabled_cloudwatch_logs_exports     = ["audit", "error", "general", "slowquery"]
  iam_database_authentication_enabled = true
  copy_tags_to_snapshot               = true
  tags                                = local.etiquetas
}
