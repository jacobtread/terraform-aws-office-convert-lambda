# Name of the office converter function for invoking
output "function_name" {
  value = aws_lambda_function.lambda.function_name
}

# ARN of the office converter function
output "function_arn" {
  value = aws_lambda_function.lambda.arn
}

# ARN for the ECR containing the office converter image
output "ecr_arn" {
  value = aws_ecr_repository.ecr.arn
}

# ARN for the aws_iam_policy that allows access to the office converter temporary
# S3 bucket for uploading input files, downloading output files, and deleting both
output "bucket_access_policy_arn" {
  value = aws_iam_policy.bucket_access.arn
}

# ARN for the aws_iam_policy that allows invoking the office converter lambda
output "invoke_policy_arn" {
  value = aws_iam_policy.invoke.arn
}

# S3 bucket for uploads and downloads
output "bucket" {
  value = aws_s3_bucket.bucket.bucket
}

# S3 bucket ARN
output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}
