#Create uc-blue mesh services
resource "aws_appmesh_virtual_service" "uc-blue-kong" {
  name      = aws_route53_record.kong.fqdn
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.uc-blue-kong.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "uc-blue-advisor-api" {
  name      = aws_route53_record.advisor-api.fqdn
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.uc-blue-advisor-api.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "uc-blue-fla" {
  name      = aws_route53_record.fla.fqdn
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.uc-blue-fla.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "uc-blue-masstrans" {
  name      = aws_route53_record.masstrans.fqdn
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.uc-blue-masstrans.name
      }
    }
  }
}

#Create uc-green mesh services
resource "aws_appmesh_virtual_service" "uc-green-kong" {
  name      = aws_route53_record.kong.fqdn
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.uc-green-kong.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "uc-green-advisor-api" {
  name      = aws_route53_record.advisor-api.fqdn
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.uc-green-advisor-api.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "uc-green-fla" {
  name      = aws_route53_record.fla.fqdn
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.uc-green-fla.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "uc-green-masstrans" {
  name      = aws_route53_record.masstrans.fqdn
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.uc-green-masstrans.name
      }
    }
  }
}