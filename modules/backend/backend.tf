/*resource "aws_s3_bucket" "test-bucket" {
  bucket        = var.bucket_name
  //force_destroy = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  
}
}*/

/*resource "aws_s3_bucket_server_side_encryption_configuration" "test-SSE" {
  bucket = aws_s3_bucket.test-bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  lifecycle {
    #prevent_destroy = true
  }
}*/


/*resource "aws_dynamodb_table" "test-DB-table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    #prevent_destroy = true
  }
}*/