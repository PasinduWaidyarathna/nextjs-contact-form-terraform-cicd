resource "aws_lambda_function" "serverless_contact_form_lambda" {
  function_name = "ServerlessContactForm"

  # change the name of the S3 bucket to the one you have 
  s3_bucket = "pasindumw-nextjs-contact-form" //S3 bucket name
  s3_key    = "lambda.zip"

  handler = "lambda/index.handler"
  runtime = "nodejs20.x"

  role = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      FROM_EMAIL  = "kvpasindumalinda@gmail.com"
      TO_EMAIL    = "kvpasindumalinda@gmail.com"
      SES_REGION  = "eu-north-1"
      CORS_ORIGIN = "*"
    }
  }
}

# resource "aws_iam_role" "lambda_exec" {
#   name = "serverless_contact_form"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# # inline policy in order to access SES
#  inline_policy {
#     name = "SESPermissionsPolicy"
#     policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "ses:SendEmail",
#         "ses:SendRawEmail"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
#   }
# }

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_contact_form"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_ses_policy" {
  name = "SESPermissionsPolicy"
  role = aws_iam_role.lambda_exec.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}



resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.serverless_contact_form_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.serverless_contact_form_api.execution_arn}/*/*" 
}
