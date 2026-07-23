variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
}

variable "aws_profile" {
  description = "The AWS cli profile to use"
  type        = string
}

variable "source_image_url" {
  description = "Source public ECR image"
  type        = string
  default     = "public.ecr.aws/jacobtread/office-convert-lambda"
}

variable "source_image_tag" {
  description = "Source public ECR image tag"
  type        = string
  default     = "0.1.0"
}

variable "architecture" {
  type        = string
  description = "The name of the Lambda function"
  default     = "arm64"
}

variable "convert_timeout_seconds" {
  type        = number
  description = "Convert timeout in seconds before the converter will internally terminate the task, should be slightly shorter than the lambda timeout to prevent the worker hanging across multiple calls"
  default     = 55
}

variable "lambda_timeout_seconds" {
  type        = number
  description = "Timeout for the lambda itself, should be slightly higher than convert_timeout_seconds"
  default     = 60
}

variable "lambda_memory_size" {
  type        = number
  description = "Memory size of the lambda, larger is recommended for cost saving as smaller amounts end up causing significantly longer convert times that end up costing more"
  default     = 2048
}

variable "lambda_function_name" {
  type        = string
  description = "Name of the lambda function"
  default     = "office-convert-lambda"
}

variable "lambda_role_name" {
  type        = string
  description = "Name of the IAM role for the lambda"
  default     = "office-convert-lambda-role"
}

variable "bucket_access_policy_name" {
  type        = string
  description = "Name of the IAM policy for allowing S3 access"
  default     = "office-convert-bucket-access"
}

variable "temporary_bucket_name" {
  type        = string
  description = "Bucket name for the office converter"
  default     = "office-convert-tmp"
}

variable "invoke_iam_policy_name" {
  type        = string
  description = "Name for the IAM policy that allows invoking the lambda function"
  default     = "office-convert-invoke"
}

variable "ecr_repository_name" {
  type        = string
  description = "Name for the ECR repository"
  default     = "office-convert-lambda"
}
