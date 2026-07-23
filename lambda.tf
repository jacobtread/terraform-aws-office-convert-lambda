# Lambda for performing office file conversions ()
resource "aws_lambda_function" "office_converter" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda.arn
  package_type  = "Image"

  architectures = [var.architecture]

  image_uri = "${aws_ecr_repository.ecr.repository_url}:${var.source_image_tag}"

  timeout     = var.lambda_timeout_seconds
  memory_size = var.lambda_memory_size

  environment {
    variables = {
      // Tell the converter to abort and kill the program if it
      // spends longer than 55s trying to convert a file
      // (Consider the program to have hanged)
      "CONVERT_TIMEOUT_SECONDS" = tostring(var.convert_timeout_seconds)
    }
  }

  depends_on = [
    null_resource.trigger_cache_pull
  ]
}
