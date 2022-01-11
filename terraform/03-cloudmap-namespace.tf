# Create cloud maps name spaces
resource "aws_service_discovery_private_dns_namespace" "uc-blue-cloud-map" {
  name = "uc.blue.mesh"
  vpc  = aws_vpc.appmesh-vpc.id
}

resource "aws_service_discovery_service" "gateway-uc-blue" {
  name = "gateway"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "kong-uc-blue" {
  name = "kong"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }
  
  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "advisor-api-uc-blue" {
  name = "advisor-api"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "fla-uc-blue" {
  name = "fla"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "masstrans-uc-blue" {
  name = "masstrans"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_private_dns_namespace" "uc-green-cloud-map" {
  name = "uc.green.mesh"
  vpc  = aws_vpc.appmesh-vpc.id
}

resource "aws_service_discovery_service" "gateway-uc-green" {
  name = "gateway"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "kong-uc-green" {
  name = "kong"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "advisor-api-uc-green" {
  name = "advisor-api"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "fla-uc-green" {
  name = "fla"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "masstrans-uc-green" {
  name = "masstrans"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
