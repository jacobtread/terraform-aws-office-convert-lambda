# Role for the office converter lambda
resource "aws_iam_role" "lambda" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach the AWSLambdaBasicExecutionRole role policy
resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


# IAM Policy that allows performing the following actions on S3 scoped to
# the office converter temporary bucket:
# - Upload files
# - Get files
# - Delete files
#
# This is granted to the converter lambda but should also be granted to anything
# you will be converting files with
resource "aws_iam_policy" "bucket_access" {
  name        = var.bucket_access_policy_name
  description = "Allows S3 access to the office converter temporary bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bucket_access" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.bucket_access.arn
}

# IAM Policy to allow invoking the converter lambda should be attached to your client
resource "aws_iam_policy" "invoke" {
  name        = var.invoke_iam_policy_name
  description = "Allows invoking the office converter lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["lambda:InvokeFunction"]
        Resource = aws_lambda_function.office_converter.arn
      }
    ]
  })
}
