resource "aws_s3_bucket" "b" {
  bucket = "my-tf-statlock-bucket-1"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_versioning" "s3version"{
    bucket = aws_s3_bucket.b.id
    versioning_configuration {
        status = "Enabled"
    }

}

resource "aws_dynamodb_table" "statelock" {
  name = "Statelock"
  billing_mode= "PAY_PER_REQUEST"
  hash_key="LockID"
  attribute {
    name="LockID"
    type= "S"
  }
}

