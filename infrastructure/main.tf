terraform {
  backend "s3" {
    bucket         = "iac-cloud-sls-terraform-state"
    key            = "iac-cloud-sls-backend"
    region         = "eu-central-1"
    dynamodb_table = "iac-cloud-sls-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform-state-bucket" {
  bucket = "iac-cloud-sls-terraform-state"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform-locks" {
  name         = "iac-cloud-sls-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
