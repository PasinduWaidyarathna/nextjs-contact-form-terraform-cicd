output "api_gateway_contact_form" {
  value = aws_api_gateway_rest_api.serverless_contact_form_api
}
output "api_gateway_url" {
  value = aws_api_gateway_deployment.dev.invoke_url
}
# output "api_gateway_url" {
#   value = "${aws_api_gateway_deployment.dev.invoke_url_prefix}${aws_api_gateway_deployment.dev.invoke_url_suffix}"
# }

