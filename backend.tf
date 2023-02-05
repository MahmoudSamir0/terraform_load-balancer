terraform {
  backend "s3"{
    bucket = "my-tf-statlock-bucket-1"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table ="Statelock"
  }
}