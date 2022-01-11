resource "aws_ecs_cluster" "uc-blue" {
  name = "uc-blue"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster" "uc-green" {
  name = "uc-green"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster" "uc-tools" {
  name = "uc-tools"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


# Blue
resource "aws_ecs_task_definition" "uc-blue-gateway" {
  family                   = "uc-blue-gateway"
  container_definitions    = templatefile("task-definition/gateway.tftpl",
                                          {
                                            config = {
                                              log_group                    = "/ecs/Gateway-UC-Blue"
                                              appmesh_nodeName             = "mesh/uc-blue/virtualGateway/mesh-gateway-vg"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-blue-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.gateway-uc-blue-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.gateway-uc-blue-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
}

resource "aws_ecs_task_definition" "uc-blue-kong" {
  family                   = "uc-blue-kong"
  container_definitions    = templatefile("task-definition/kong.tftpl",
                                          {
                                            config = {
                                              kong_host                    = aws_db_instance.uc-blue-kong.address,
                                              kong_username                = aws_secretsmanager_secret_version.uc-blue-username.arn,
                                              kong_password                = aws_secretsmanager_secret_version.uc-blue-password.arn
                                              log_group                    = "/ecs/Kong-UC-Blue"
                                              appmesh_nodeName             = "mesh/uc-blue/virtualNode/kong-vn"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-blue-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.kong-uc-blue-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.kong-uc-blue-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = "8000"
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      IgnoredGID         = ""
      EgressIgnoredPorts = ""
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }
}

resource "aws_ecs_task_definition" "uc-blue-advisor-api" {
  family                   = "uc-blue-advisor-api"
  container_definitions    = templatefile("task-definition/service.tftpl",
                                          {
                                            config = {
                                              color                        = "Blue"
                                              service_name                 = "Advisor-API"
                                              container_name               = local.advisor_api_service_name
                                              log_group                    = "/ecs/Advisor-API-UC-Blue"
                                              appmesh_nodeName             = "mesh/uc-blue/virtualNode/advisor-api-vn"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-blue-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.advisor-api-uc-blue-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.advisor-api-uc-blue-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              service_image                = format("%s:%s", aws_ecr_repository.aws-mesh-service.repository_url, local.service_image_version)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                              downstream_endpoint          = format("http://%s:%s", aws_route53_record.fla.fqdn, local.service_port)
                                              service_port                 = local.service_port
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = "8080"
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      IgnoredGID         = ""
      EgressIgnoredPorts = ""
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }
}

resource "aws_ecs_task_definition" "uc-blue-fla" {
  family                   = "uc-blue-fla"
  container_definitions    = templatefile("task-definition/service.tftpl",
                                          {
                                            config = {
                                              color                        = "Blue"
                                              service_name                 = "FLA"
                                              container_name               = local.fla_service_name
                                              log_group                    = "/ecs/FLA-UC-Blue"
                                              appmesh_nodeName             = "mesh/uc-blue/virtualNode/fla-vn"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-blue-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.fla-uc-blue-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.fla-uc-blue-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              service_image                = format("%s:%s", aws_ecr_repository.aws-mesh-service.repository_url, local.service_image_version)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                              downstream_endpoint          = format("http://%s:%s", aws_route53_record.masstrans.fqdn, local.service_port)
                                              service_port                 = local.service_port
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = "8080"
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      IgnoredGID         = ""
      EgressIgnoredPorts = ""
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }
}

resource "aws_ecs_task_definition" "uc-blue-masstrans" {
  family                   = "uc-blue-masstrans"
  container_definitions    = templatefile("task-definition/service.tftpl",
                                          {
                                            config = {
                                              color                        = "Blue"
                                              service_name                 = "Masstrans"
                                              container_name               = local.masstrans_service_name
                                              log_group                    = "/ecs/Masstrans-UC-Blue"
                                              appmesh_nodeName             = "mesh/uc-blue/virtualNode/masstrans-vn"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-blue-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.masstrans-uc-blue-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.masstrans-uc-blue-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              service_image                = format("%s:%s", aws_ecr_repository.aws-mesh-service.repository_url, local.service_image_version)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                              downstream_endpoint          = local.downstream_endpoint_last
                                              service_port                 = local.service_port
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = "8080"
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      IgnoredGID         = ""
      EgressIgnoredPorts = ""
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }
}

# Green
resource "aws_ecs_task_definition" "uc-green-gateway" {
  family                   = "uc-green-gateway"
  container_definitions    = templatefile("task-definition/gateway.tftpl",
                                          {
                                            config = {
                                              log_group                    = "/ecs/Gateway-UC-Green"
                                              appmesh_nodeName             = "mesh/uc-green/virtualGateway/mesh-gateway-vg"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-green-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.gateway-uc-green-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.gateway-uc-green-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
}

resource "aws_ecs_task_definition" "uc-green-kong" {
  family                   = "uc-green-kong"
  container_definitions    = templatefile("task-definition/kong.tftpl",
                                          {
                                            config = {
                                              kong_host                    = aws_db_instance.uc-green-kong.address,
                                              kong_username                = aws_secretsmanager_secret_version.uc-green-username.arn,
                                              kong_password                = aws_secretsmanager_secret_version.uc-green-password.arn
                                              log_group                    = "/ecs/Kong-UC-Green"
                                              appmesh_nodeName             = "mesh/uc-green/virtualNode/kong-vn"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-green-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.kong-uc-green-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.kong-uc-green-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = "8000"
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      IgnoredGID         = ""
      EgressIgnoredPorts = ""
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }
}

resource "aws_ecs_task_definition" "uc-green-advisor-api" {
  family                   = "uc-green-advisor-api"
  container_definitions    = templatefile("task-definition/service.tftpl",
                                          {
                                            config = {
                                              color                        = "Green"
                                              service_name                 = "Advisor-API"
                                              container_name               = local.advisor_api_service_name
                                              log_group                    = "/ecs/Advisor-API-UC-Green"
                                              appmesh_nodeName             = "mesh/uc-green/virtualNode/advisor-api-vn"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-green-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.advisor-api-uc-green-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.advisor-api-uc-green-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              service_image                = format("%s:%s", aws_ecr_repository.aws-mesh-service.repository_url, local.service_image_version)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                              downstream_endpoint          = format("http://%s:%s", aws_route53_record.fla.fqdn, local.service_port)
                                              service_port                 = local.service_port
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = "8080"
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      IgnoredGID         = ""
      EgressIgnoredPorts = ""
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }
}

resource "aws_ecs_task_definition" "uc-green-fla" {
  family                   = "uc-green-fla"
  container_definitions    = templatefile("task-definition/service.tftpl",
                                          {
                                            config = {
                                              color                        = "Green"
                                              service_name                 = "FLA"
                                              container_name               = local.fla_service_name
                                              log_group                    = "/ecs/FLA-UC-Green"
                                              appmesh_nodeName             = "mesh/uc-green/virtualNode/fla-vn"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-green-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.fla-uc-green-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.fla-uc-green-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              service_image                = format("%s:%s", aws_ecr_repository.aws-mesh-service.repository_url, local.service_image_version)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                              downstream_endpoint          = format("http://%s:%s", aws_route53_record.masstrans.fqdn, local.service_port)
                                              service_port                 = local.service_port
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = "8080"
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      IgnoredGID         = ""
      EgressIgnoredPorts = ""
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }
}

resource "aws_ecs_task_definition" "uc-green-masstrans" {
  family                   = "uc-green-masstrans"
  container_definitions    = templatefile("task-definition/service.tftpl",
                                          {
                                            config = {
                                              color                        = "Green"
                                              service_name                 = "Masstrans"
                                              container_name               = local.masstrans_service_name
                                              log_group                    = "/ecs/Masstrans-UC-Green"
                                              appmesh_nodeName             = "mesh/uc-green/virtualNode/masstrans-vn"
                                              appmesh_rootCertificate      = aws_secretsmanager_secret_version.ca-uc-green-cert.arn
                                              appmesh_nodeCertificateChain = aws_secretsmanager_secret_version.masstrans-uc-green-cert-chain.arn
                                              appmesh_nodeCertificateKey   = aws_secretsmanager_secret_version.masstrans-uc-green-key.arn
                                              prometheus_remote_write      = format("%sapi/v1/remote_write", aws_prometheus_workspace.uc-appmesh.prometheus_endpoint)
                                              service_image                = format("%s:%s", aws_ecr_repository.aws-mesh-service.repository_url, local.service_image_version)
                                              envoy_image                  = format("%s:%s", aws_ecr_repository.aws-mesh-envoy.repository_url, local.envoy_image_version)
                                              otel_agent_image             = format("%s:%s", aws_ecr_repository.aws-mesh-otel-agent.repository_url, local.otel_agent_image_version)
                                              downstream_endpoint          = local.downstream_endpoint_last
                                              service_port                 = local.service_port
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = "8080"
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      IgnoredGID         = ""
      EgressIgnoredPorts = ""
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }
}

# Tools
# Kong DB Blue secrets
resource "aws_secretsmanager_secret" "uc-blue-username" {
  name = "uc-blue-username"
}

resource "aws_secretsmanager_secret_version" "uc-blue-username" {
  secret_id     = aws_secretsmanager_secret.uc-blue-username.id
  secret_string = "kong"
}

resource "random_password" "uc-blue-password" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "uc-blue-password" {
  name = "uc-blue-password"
}

resource "aws_secretsmanager_secret_version" "uc-blue-password" {
  secret_id     = aws_secretsmanager_secret.uc-blue-password.id
  secret_string = random_password.uc-blue-password.result
}

# Kong Bootstrap Blue
resource "aws_ecs_task_definition" "uc-blue-kong-bootstrap" {
  family                   = "uc-blue-kong-bootstrap"
  container_definitions    = templatefile("tool-tasks/kong-bootstrap.tftpl",
                                          {
                                            kong = {
                                              host     = aws_db_instance.uc-blue-kong.address,
                                              username = aws_secretsmanager_secret_version.uc-blue-username.arn,
                                              password = aws_secretsmanager_secret_version.uc-blue-password.arn
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }

  provisioner "local-exec" {
    command = <<EOT
mkdir -p kong-scripts &&
echo '#!/bin/sh
aws ecs run-task \
--task-definition ${aws_ecs_task_definition.uc-blue-kong-bootstrap.arn} \
--cluster ${aws_ecs_cluster.uc-blue.arn} \
--network-configuration "{ \"awsvpcConfiguration\": { \"subnets\": [ \"${aws_subnet.appmesh-subnet-1.id}\", \"${aws_subnet.appmesh-subnet-2.id}\" ], \"securityGroups\": [ \"${aws_security_group.appmesh-allow-all.id}\" ], \"assignPublicIp\": \"ENABLED\" } }" \
--launch-type FARGATE' > kong-scripts/run-uc-blue-kong-bootstrap.sh &&
chmod +x kong-scripts/run-uc-blue-kong-bootstrap.sh
    EOT
  }
}

# Kong Migration Blue
resource "aws_ecs_task_definition" "uc-blue-kong-migration" {
  family                   = "uc-blue-kong-migration"
  container_definitions    = templatefile("tool-tasks/kong-migration.tftpl",
                                          {
                                            kong = {
                                              host     = aws_db_instance.uc-blue-kong.address,
                                              username = aws_secretsmanager_secret_version.uc-blue-username.arn,
                                              password = aws_secretsmanager_secret_version.uc-blue-password.arn
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }

  provisioner "local-exec" {
    command = <<EOT
mkdir -p kong-scripts &&
echo '#!/bin/sh
aws ecs run-task \
--task-definition ${aws_ecs_task_definition.uc-blue-kong-migration.arn} \
--cluster ${aws_ecs_cluster.uc-blue.arn} \
--network-configuration "{ \"awsvpcConfiguration\": { \"subnets\": [ \"${aws_subnet.appmesh-subnet-1.id}\", \"${aws_subnet.appmesh-subnet-2.id}\" ], \"securityGroups\": [ \"${aws_security_group.appmesh-allow-all.id}\" ], \"assignPublicIp\": \"ENABLED\" } }" \
--launch-type FARGATE' > kong-scripts/run-uc-blue-kong-migration.sh &&
chmod +x kong-scripts/run-uc-blue-kong-migration.sh
    EOT
  }
}

# Kong DB Green secrets
resource "aws_secretsmanager_secret" "uc-green-username" {
  name = "uc-green-username"
}

resource "aws_secretsmanager_secret_version" "uc-green-username" {
  secret_id     = aws_secretsmanager_secret.uc-green-username.id
  secret_string = "kong"
}

resource "random_password" "uc-green-password" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "uc-green-password" {
  name = "uc-green-password"
}

resource "aws_secretsmanager_secret_version" "uc-green-password" {
  secret_id     = aws_secretsmanager_secret.uc-green-password.id
  secret_string = random_password.uc-green-password.result
}

# Kong Bootstrap Green
resource "aws_ecs_task_definition" "uc-green-kong-bootstrap" {
  family                   = "uc-green-kong-bootstrap"
  container_definitions    = templatefile("tool-tasks/kong-bootstrap.tftpl",
                                          {
                                            kong = {
                                              host     = aws_db_instance.uc-green-kong.address,
                                              username = aws_secretsmanager_secret_version.uc-green-username.arn,
                                              password = aws_secretsmanager_secret_version.uc-green-password.arn
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }

  provisioner "local-exec" {
    command = <<EOT
mkdir -p kong-scripts &&
echo '#!/bin/sh
aws ecs run-task \
--task-definition ${aws_ecs_task_definition.uc-green-kong-bootstrap.arn} \
--cluster ${aws_ecs_cluster.uc-green.arn} \
--network-configuration "{ \"awsvpcConfiguration\": { \"subnets\": [ \"${aws_subnet.appmesh-subnet-1.id}\", \"${aws_subnet.appmesh-subnet-2.id}\" ], \"securityGroups\": [ \"${aws_security_group.appmesh-allow-all.id}\" ], \"assignPublicIp\": \"ENABLED\" } }" \
--launch-type FARGATE' > kong-scripts/run-uc-green-kong-bootstrap.sh &&
chmod +x kong-scripts/run-uc-green-kong-bootstrap.sh
    EOT
  }
}

# Kong Migration Green
resource "aws_ecs_task_definition" "uc-green-kong-migration" {
  family                   = "uc-green-kong-migration"
  container_definitions    = templatefile("tool-tasks/kong-migration.tftpl",
                                          {
                                            kong = {
                                              host     = aws_db_instance.uc-green-kong.address,
                                              username = aws_secretsmanager_secret_version.uc-green-username.arn,
                                              password = aws_secretsmanager_secret_version.uc-green-password.arn
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }

  provisioner "local-exec" {
    command = <<EOT
mkdir -p kong-scripts &&
echo '#!/bin/sh
aws ecs run-task \
--task-definition ${aws_ecs_task_definition.uc-green-kong-migration.arn} \
--cluster ${aws_ecs_cluster.uc-green.arn} \
--network-configuration "{ \"awsvpcConfiguration\": { \"subnets\": [ \"${aws_subnet.appmesh-subnet-1.id}\", \"${aws_subnet.appmesh-subnet-2.id}\" ], \"securityGroups\": [ \"${aws_security_group.appmesh-allow-all.id}\" ], \"assignPublicIp\": \"ENABLED\" } }" \
--launch-type FARGATE' > kong-scripts/run-uc-green-kong-migration.sh &&
chmod +x kong-scripts/run-uc-green-kong-migration.sh
    EOT
  }
}

# Grafana
resource "aws_ecs_task_definition" "uc-grafana" {
  family                   = "uc-grafana"
  container_definitions    = templatefile("tool-tasks/grafana.tftpl",
                                          {
                                            config = {
                                              log_group = "/ecs/UC-Tools"
                                            }
                                          })
  execution_role_arn       = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.appMeshEcsTaskExecutionRole.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family  = "LINUX"
  }
}
