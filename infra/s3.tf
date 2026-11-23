# ---------- S3 ----------
resource "aws_s3_bucket" "datos" {
  # checkov:skip=CKV_AWS_144: Replicación entre regiones no requerida para datos de demo no críticos. Aprobado por: Líder de Seguridad (ticket SEC-001). Vence: 2027-03-31
  bucket = "demo-datos-app"
  tags   = local.etiquetas
}

resource "aws_s3_bucket_public_access_block" "datos" {
  bucket                  = aws_s3_bucket.datos.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "datos" {
  bucket = aws_s3_bucket.datos.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "datos" {
  bucket = aws_s3_bucket.datos.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.principal.arn
    }
  }
}

resource "aws_s3_bucket_logging" "datos" {
  bucket        = aws_s3_bucket.datos.id
  target_bucket = aws_s3_bucket.datos.id
  target_prefix = "logs/"
}

resource "aws_s3_bucket_lifecycle_configuration" "datos" {
  bucket = aws_s3_bucket.datos.id
  rule {
    id     = "expirar-versiones-viejas"
    status = "Enabled"
    filter {}
    noncurrent_version_expiration {
      noncurrent_days = 90
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_sns_topic" "eventos_s3" {
  name              = "eventos-s3-demo"
  kms_master_key_id = aws_kms_key.principal.id
  tags              = local.etiquetas
}

resource "aws_s3_bucket_notification" "datos" {
  bucket = aws_s3_bucket.datos.id
  topic {
    topic_arn = aws_sns_topic.eventos_s3.arn
    events    = ["s3:ObjectCreated:*"]
  }
}
