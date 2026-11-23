# Bucket S3 sin cifrado, sin versionado, sin logs y con ACL pública
resource "aws_s3_bucket" "datos" {
  bucket = "demo-datos-app"
  tags = {
    Proyecto = "demo-iac"
  }
}

resource "aws_s3_bucket_acl" "datos" {
  bucket = aws_s3_bucket.datos.id
  acl    = "public-read"
}
