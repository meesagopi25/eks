provider "aws" {
  region = var.aws_region

  # Jenkins should assume this role (recommended for CI/CD)
default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Platform-Team"
    }
  }
}

