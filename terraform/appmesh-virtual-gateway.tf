#Create uc-blue mesh virtual gateway
resource "aws_appmesh_virtual_gateway" "uc-blue-mesh-gateway-vg" {
  name      = "mesh-gateway-vg"
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    listener {
      port_mapping {
        port     = 8000
        protocol = "http"
      }
    }

    backend_defaults {
        client_policy {
            tls {
                enforce = true
                validation {
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
                certificate {
                    file {
                        certificate_chain = "/keys/node_cert_chain.pem"
                        private_key = "/keys/node_cert_key.pem"
                    }
                }
            }
        }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
      }
    }
  }
}

resource "aws_appmesh_gateway_route" "uc-blue-kong" {
  name                 = "kong-gr"
  mesh_name            = aws_appmesh_mesh.uc-blue.id
  virtual_gateway_name = aws_appmesh_virtual_gateway.uc-blue-mesh-gateway-vg.name

  spec {
    http_route {
      action {
        target {
          virtual_service {
            virtual_service_name = aws_appmesh_virtual_service.uc-blue-kong.name
          }
        }
      }

      match {
        prefix = "/"
      }
    }
  }
}

#Create uc-green mesh virtual gateway
resource "aws_appmesh_virtual_gateway" "uc-green-mesh-gateway-vg" {
  name      = "mesh-gateway-vg"
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    listener {
      port_mapping {
        port     = 8000
        protocol = "http"
      }
    }

    backend_defaults {
        client_policy {
            tls {
                enforce = true
                validation {
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
                certificate {
                    file {
                        certificate_chain = "/keys/node_cert_chain.pem"
                        private_key = "/keys/node_cert_key.pem"
                    }
                }
            }
        }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
      }
    }
  }
}

resource "aws_appmesh_gateway_route" "uc-green-kong" {
  name                 = "kong-gr"
  mesh_name            = aws_appmesh_mesh.uc-green.id
  virtual_gateway_name = aws_appmesh_virtual_gateway.uc-green-mesh-gateway-vg.name

  spec {
    http_route {
      action {
        target {
          virtual_service {
            virtual_service_name = aws_appmesh_virtual_service.uc-green-kong.name
          }
        }
      }

      match {
        prefix = "/"
      }
    }
  }
}