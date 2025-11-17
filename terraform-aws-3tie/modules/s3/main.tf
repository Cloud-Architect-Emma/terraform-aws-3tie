resource "aws_s3_bucket" "static" {
  bucket = "my-static-bucket-${random_id.suffix.hex}"
}
