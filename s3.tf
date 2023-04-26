resource "aws_s3_bucket" "backend" {
  bucket = "spicegirlsparadise-s3v2"
}

resource "aws_s3_bucket_public_access_block" "backend" {
  bucket = aws_s3_bucket.backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "backend" {
  statement {
    sid = "Public View"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      aws_s3_bucket.backend.arn, "${aws_s3_bucket.backend.arn}/*"
    ]
  }
}

# resource "aws_s3_bucket_policy" "backend" {
#   bucket = aws_s3_bucket.backend.id
#   policy = data.aws_iam_policy_document.backend.json
# }

# resource "aws_kms_key" "backend" {
#   description             = "This key is used to encrypt bucket objects"
#   deletion_window_in_days = 16
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
#    bucket = aws_s3_bucket.backend.id

  # rule {
  #   apply_server_side_encryption_by_default {
  #     kms_master_key_id = aws_kms_key.backend.arn
  #     sse_algorithm     = "aws:kms"
  #   }
  # }
#}



# resource "aws_s3_bucket_acl" "log_bucket_acl" {
#   bucket = aws_s3_bucket.backend.id
#   acl    = "log-delivery-write"
# }

# resource "aws_s3_bucket_logging" "backend" {
#    bucket = aws_s3_bucket.backend.id

#   target_bucket = aws_s3_bucket.backend.id
#   target_prefix = "log/"
#}