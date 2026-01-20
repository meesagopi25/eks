variable "aws_region" {
  description = "AWS region where EKS will be deployed"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "cicd_role_arn" {
  description = "IAM role ARN assumed by Jenkins (optional)"
  type        = string
  default     = ""
}
