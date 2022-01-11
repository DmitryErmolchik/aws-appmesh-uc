# Blue Services
resource "aws_ecs_service" "uc-blue-gateway" {
  name            = "gateway"
  cluster         = aws_ecs_cluster.uc-blue.id
  task_definition = aws_ecs_task_definition.uc-blue-gateway.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.gateway-uc-blue.arn
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.uc-blue-mesh-tg.arn
    container_name   = "envoy"
    container_port   = 8000
  }
}

resource "aws_ecs_service" "uc-blue-kong" {
  name            = "kong"
  cluster         = aws_ecs_cluster.uc-blue.id
  task_definition = aws_ecs_task_definition.uc-blue-kong.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.kong-uc-blue.arn
  }
}

resource "aws_ecs_service" "uc-blue-advisor-api" {
  name            = local.advisor_api_service_name
  cluster         = aws_ecs_cluster.uc-blue.id
  task_definition = aws_ecs_task_definition.uc-blue-advisor-api.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.advisor-api-uc-blue.arn
  }
}

resource "aws_ecs_service" "uc-blue-fla" {
  name            = local.fla_service_name
  cluster         = aws_ecs_cluster.uc-blue.id
  task_definition = aws_ecs_task_definition.uc-blue-fla.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.fla-uc-blue.arn
  }
}

resource "aws_ecs_service" "uc-blue-masstrans" {
  name            = local.masstrans_service_name
  cluster         = aws_ecs_cluster.uc-blue.id
  task_definition = aws_ecs_task_definition.uc-blue-masstrans.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.masstrans-uc-blue.arn
  }
}


# Green Services
resource "aws_ecs_service" "uc-green-gateway" {
  name            = "gateway"
  cluster         = aws_ecs_cluster.uc-green.id
  task_definition = aws_ecs_task_definition.uc-green-gateway.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.gateway-uc-green.arn
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.uc-green-mesh-tg.arn
    container_name   = "envoy"
    container_port   = 8000
  }
}

resource "aws_ecs_service" "uc-green-kong" {
  name            = "kong"
  cluster         = aws_ecs_cluster.uc-green.id
  task_definition = aws_ecs_task_definition.uc-green-kong.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.kong-uc-green.arn
  }
}

resource "aws_ecs_service" "uc-green-advisor-api" {
  name            = local.advisor_api_service_name
  cluster         = aws_ecs_cluster.uc-green.id
  task_definition = aws_ecs_task_definition.uc-green-advisor-api.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.advisor-api-uc-green.arn
  }
}

resource "aws_ecs_service" "uc-green-fla" {
  name            = local.fla_service_name
  cluster         = aws_ecs_cluster.uc-green.id
  task_definition = aws_ecs_task_definition.uc-green-fla.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.fla-uc-green.arn
  }
}

resource "aws_ecs_service" "uc-green-masstrans" {
  name            = local.masstrans_service_name
  cluster         = aws_ecs_cluster.uc-green.id
  task_definition = aws_ecs_task_definition.uc-green-masstrans.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

  service_registries {
      registry_arn = aws_service_discovery_service.masstrans-uc-green.arn
  }
}

resource "aws_ecs_service" "uc-grafana" {
  name            = "grafana"
  cluster         = aws_ecs_cluster.uc-tools.id
  task_definition = aws_ecs_task_definition.uc-grafana.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
      subnets          = [ 
          aws_subnet.appmesh-subnet-1.id,
          aws_subnet.appmesh-subnet-2.id
      ]
      security_groups  = [
          aws_security_group.appmesh-allow-all.id
      ]
      assign_public_ip = true
  }

    load_balancer {
    target_group_arn = aws_lb_target_group.uc-grafana-tg.arn
    container_name   = "grafana"
    container_port   = 3000
  }

}