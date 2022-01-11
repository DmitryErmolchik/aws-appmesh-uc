#Create uc-blue mesh routes
resource "aws_appmesh_route" "uc-blue-kong" {
  name                = "kong-route"
  mesh_name           = aws_appmesh_mesh.uc-blue.id
  virtual_router_name = aws_appmesh_virtual_router.uc-blue-kong.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 3

        per_retry_timeout {
          unit  = "s"
          value = 5
        }
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.uc-blue-kong.name
          weight       = 100
        }
      }
    }
  }
}

resource "aws_appmesh_route" "uc-blue-advisor-api" {
  name                = "advisor-api-route"
  mesh_name           = aws_appmesh_mesh.uc-blue.id
  virtual_router_name = aws_appmesh_virtual_router.uc-blue-advisor-api.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 3

        per_retry_timeout {
          unit  = "s"
          value = 5
        }
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.uc-blue-advisor-api.name
          weight       = 100
        }
      }
    }
  }
}

resource "aws_appmesh_route" "uc-blue-fla" {
  name                = "fla-route"
  mesh_name           = aws_appmesh_mesh.uc-blue.id
  virtual_router_name = aws_appmesh_virtual_router.uc-blue-fla.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 3

        per_retry_timeout {
          unit  = "s"
          value = 5
        }
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.uc-blue-fla.name
          weight       = 100
        }
      }
    }
  }
}

resource "aws_appmesh_route" "uc-blue-masstrans" {
  name                = "masstrans-route"
  mesh_name           = aws_appmesh_mesh.uc-blue.id
  virtual_router_name = aws_appmesh_virtual_router.uc-blue-masstrans.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 3

        per_retry_timeout {
          unit  = "s"
          value = 5
        }
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.uc-blue-masstrans.name
          weight       = 100
        }
      }
    }
  }
}

#Create uc-green mesh routes
resource "aws_appmesh_route" "uc-green-kong" {
  name                = "kong-route"
  mesh_name           = aws_appmesh_mesh.uc-green.id
  virtual_router_name = aws_appmesh_virtual_router.uc-green-kong.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 3

        per_retry_timeout {
          unit  = "s"
          value = 5
        }
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.uc-green-kong.name
          weight       = 100
        }
      }
    }
  }
}

resource "aws_appmesh_route" "uc-green-advisor-api" {
  name                = "advisor-api-route"
  mesh_name           = aws_appmesh_mesh.uc-green.id
  virtual_router_name = aws_appmesh_virtual_router.uc-green-advisor-api.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 3

        per_retry_timeout {
          unit  = "s"
          value = 5
        }
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.uc-green-advisor-api.name
          weight       = 100
        }
      }
    }
  }
}

resource "aws_appmesh_route" "uc-green-fla" {
  name                = "fla-route"
  mesh_name           = aws_appmesh_mesh.uc-green.id
  virtual_router_name = aws_appmesh_virtual_router.uc-green-fla.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 3

        per_retry_timeout {
          unit  = "s"
          value = 5
        }
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.uc-green-fla.name
          weight       = 100
        }
      }
    }
  }
}

resource "aws_appmesh_route" "uc-green-masstrans" {
  name                = "masstrans-route"
  mesh_name           = aws_appmesh_mesh.uc-green.id
  virtual_router_name = aws_appmesh_virtual_router.uc-green-masstrans.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 3

        per_retry_timeout {
          unit  = "s"
          value = 5
        }
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.uc-green-masstrans.name
          weight       = 100
        }
      }
    }
  }
}