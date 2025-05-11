module "serverless-backend-aws" {
  source = "./modules/serverless-backend-aws"
}

module "cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"

  api_id          = module.serverless-backend-aws.api_gateway_contact_form.id
  api_resource_id = module.serverless-backend-aws.api_gateway_contact_form.root_resource_id
  allow_headers = ["Content-Type"]
  allow_methods = ["OPTIONS", "POST"]
  allow_origin = "http://localhost:3000" 
}
