# My S3 Bucket 


resource "aws_s3_bucket" "project5_ss3" {
  bucket = "my-tf-test-bucket-project5"
  acl    = "private"

  tags = {
    Name        = "s3-project5"
    Environment = "test"
  }
}
