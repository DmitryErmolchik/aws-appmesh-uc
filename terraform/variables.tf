data "aws_caller_identity" "current" {}

locals {
    service_image_version    = "1.0.0"
    envoy_image_version      = "v1.20.0.1-prod"
    otel_agent_image_version = "0.15.1"
    service_port             = 8080
    downstream_endpoint_last = "http://example.com"
    kong_service_name        = "kong"
    advisor_api_service_name = "advisor-api"
    fla_service_name         = "fla"
    masstrans_service_name   = "masstrans"
}