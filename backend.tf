terraform {
  backend "s3" {
    bucket         = "eks-terraform-state-v1-us-east-1"
    key            = "prod/eks.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

