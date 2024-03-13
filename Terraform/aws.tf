
variable "region" {
 type = any 
}
variable "access_key" {
  type = any
}
variable "secret_key" {
  type= any
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


resource "aws_s3_bucket" "luxury-bucket" {
  bucket = "luxury-bucket-1999"
}
