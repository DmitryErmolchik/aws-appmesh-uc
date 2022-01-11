#Create uc-blue mesh virtual routes
resource "aws_appmesh_virtual_router" "uc-blue-kong" {
  name      = "kong-vr"
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    listener {
      port_mapping {
        port     = 8000
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "uc-blue-advisor-api" {
  name      = "advisor-api-vr"
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "uc-blue-fla" {
  name      = "fla-vr"
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "uc-blue-masstrans" {
  name      = "masstrans-vr"
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
  }
}

#Create uc-green mesh virtual routes
resource "aws_appmesh_virtual_router" "uc-green-kong" {
  name      = "kong-vr"
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    listener {
      port_mapping {
        port     = 8000
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "uc-green-advisor-api" {
  name      = "advisor-api-vr"
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "uc-green-fla" {
  name      = "fla-vr"
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "uc-green-masstrans" {
  name      = "masstrans-vr"
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }
  }
}