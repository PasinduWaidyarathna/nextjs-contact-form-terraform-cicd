resource "aws_api_gateway_rest_api" "serverless_contact_form_api" {
  name = "serverless-contact-form-api"
  description = "API Gateway for the serverless contact form"
}


resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.serverless_contact_form_api.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.serverless_contact_form_lambda.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_contact_form_api.id
  resource_id   = aws_api_gateway_rest_api.serverless_contact_form_api.root_resource_id
  http_method   = "POST"
  authorization = "NONE"
}


resource "aws_api_gateway_deployment" "dev" {
  depends_on = [aws_api_gateway_integration.lambda]

  rest_api_id = aws_api_gateway_rest_api.serverless_contact_form_api.id
  stage_name  = "dev"
}
