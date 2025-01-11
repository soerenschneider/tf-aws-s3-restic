resource "aws_s3_bucket" "bucket" {
  #checkov:skip=CKV_AWS_18:Not needed
  #checkov:skip=CKV_AWS_21:Not needed, restic takes care
  #checkov:skip=CKV2_AWS_61:Not needed, restic takes care
  #checkov:skip=CKV2_AWS_62:Not needed
  #checkov:skip=CKV_AWS_144:Not needed
  #checkov:skip=CKV_AWS_145:Not using BYOK
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "object" {
  for_each = { for repo in var.repos : repo.name => repo }
  bucket   = aws_s3_bucket.bucket.id
  key      = "${each.key}/}"
}
