# Create uc-blue mesh virtual nodes
resource "aws_appmesh_virtual_node" "uc-blue-kong" {
  name      = "kong-vn"
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_route53_record.advisor-api.fqdn
      }
    }

    listener {
      port_mapping {
        port     = 8000
        protocol = "http"
      }
      tls {
          mode = "STRICT"
          certificate {
              file {
                  certificate_chain = "/keys/node_cert_chain.pem"
                  private_key = "/keys/node_cert_key.pem"
                }
            }
                validation {
                    subject_alternative_names {
                        match {
                            exact = [ format("%s.%s", aws_service_discovery_service.gateway-uc-blue.name, aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.name) ]
                        }
                    }
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = "kong"
        namespace_name = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.name
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
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
  }
}

resource "aws_appmesh_virtual_node" "uc-blue-advisor-api" {
  name      = format("%s-vn", local.advisor_api_service_name)
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_route53_record.fla.fqdn
      }
    }

    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
      tls {
          mode = "STRICT"
          certificate {
              file {
                  certificate_chain = "/keys/node_cert_chain.pem"
                  private_key = "/keys/node_cert_key.pem"
                }
            }
                validation {
                    subject_alternative_names {
                        match {
                            exact = [ format("%s.%s", aws_service_discovery_service.kong-uc-blue.name, aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.name) ]
                        }
                    }
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = local.advisor_api_service_name
        namespace_name = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.name
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
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
  }
}

resource "aws_appmesh_virtual_node" "uc-blue-fla" {
  name      = format("%s-vn", local.fla_service_name)
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_route53_record.masstrans.fqdn
      }
    }

    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
      tls {
          mode = "STRICT"
          certificate {
              file {
                  certificate_chain = "/keys/node_cert_chain.pem"
                  private_key = "/keys/node_cert_key.pem"
                }
            }
                validation {
                    subject_alternative_names {
                        match {
                            exact = [ format("%s.%s", aws_service_discovery_service.advisor-api-uc-blue.name, aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.name) ]
                        }
                    }
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = local.fla_service_name
        namespace_name = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.name
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
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
  }
}

resource "aws_appmesh_virtual_node" "uc-blue-masstrans" {
  name      = format("%s-vn", local.masstrans_service_name)
  mesh_name = aws_appmesh_mesh.uc-blue.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
      tls {
          mode = "STRICT"
          certificate {
              file {
                  certificate_chain = "/keys/node_cert_chain.pem"
                  private_key = "/keys/node_cert_key.pem"
                }
            }
                validation {
                    subject_alternative_names {
                        match {
                            exact = [ format("%s.%s", aws_service_discovery_service.fla-uc-blue.name, aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.name) ]
                        }
                    }
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = local.masstrans_service_name
        namespace_name = aws_service_discovery_private_dns_namespace.uc-blue-cloud-map.name
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
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
  }
}


# Create uc-green mesh virtual nodes
resource "aws_appmesh_virtual_node" "uc-green-kong" {
  name      = "kong-vn"
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_route53_record.advisor-api.fqdn
      }
    }

    listener {
      port_mapping {
        port     = 8000
        protocol = "http"
      }
      tls {
          mode = "STRICT"
          certificate {
              file {
                  certificate_chain = "/keys/node_cert_chain.pem"
                  private_key = "/keys/node_cert_key.pem"
                }
            }
                validation {
                    subject_alternative_names {
                        match {
                            exact = [ format("%s.%s", aws_service_discovery_service.gateway-uc-green.name, aws_service_discovery_private_dns_namespace.uc-green-cloud-map.name) ]
                        }
                    }
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = "kong"
        namespace_name = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.name
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
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
  }
}

resource "aws_appmesh_virtual_node" "uc-green-advisor-api" {
  name      = format("%s-vn", local.advisor_api_service_name)
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_route53_record.fla.fqdn
      }
    }

    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
      tls {
          mode = "STRICT"
          certificate {
              file {
                  certificate_chain = "/keys/node_cert_chain.pem"
                  private_key = "/keys/node_cert_key.pem"
                }
            }
                validation {
                    subject_alternative_names {
                        match {
                            exact = [ format("%s.%s", aws_service_discovery_service.kong-uc-green.name, aws_service_discovery_private_dns_namespace.uc-green-cloud-map.name) ]
                        }
                    }
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = local.advisor_api_service_name
        namespace_name = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.name
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
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
  }
}

resource "aws_appmesh_virtual_node" "uc-green-fla" {
  name      = format("%s-vn", local.fla_service_name)
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_route53_record.masstrans.fqdn
      }
    }

    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
      tls {
          mode = "STRICT"
          certificate {
              file {
                  certificate_chain = "/keys/node_cert_chain.pem"
                  private_key = "/keys/node_cert_key.pem"
                }
            }
                validation {
                    subject_alternative_names {
                        match {
                            exact = [ format("%s.%s", aws_service_discovery_service.advisor-api-uc-green.name, aws_service_discovery_private_dns_namespace.uc-green-cloud-map.name) ]
                        }
                    }
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = local.fla_service_name
        namespace_name = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.name
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
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
  }
}

resource "aws_appmesh_virtual_node" "uc-green-masstrans" {
  name      = format("%s-vn", local.masstrans_service_name)
  mesh_name = aws_appmesh_mesh.uc-green.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
      tls {
          mode = "STRICT"
          certificate {
              file {
                  certificate_chain = "/keys/node_cert_chain.pem"
                  private_key = "/keys/node_cert_key.pem"
                }
            }
                validation {
                    subject_alternative_names {
                        match {
                            exact = [ format("%s.%s", aws_service_discovery_service.fla-uc-green.name, aws_service_discovery_private_dns_namespace.uc-green-cloud-map.name) ]
                        }
                    }
                    trust {
                        file {
                            certificate_chain = "/keys/ca_cert.pem"
                        }
                    }
                }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = local.masstrans_service_name
        namespace_name = aws_service_discovery_private_dns_namespace.uc-green-cloud-map.name
      }
    }

    logging {
      access_log {
        file {
          path = "/dev/stdout"
        }
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
  }
}