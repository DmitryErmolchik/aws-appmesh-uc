resource "aws_ecr_repository" "aws-mesh-service" {
  name                 = "aws-mesh/service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "aws-mesh-envoy" {
  name                 = "aws-mesh/envoy"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "aws-mesh-otel-agent" {
  name                 = "aws-mesh/otel-agent"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}