resource "aws_lb_target_group" "uc-blue-mesh-tg" {
  name        = "uc-blue-mesh-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.appmesh-vpc.id

  health_check {
    path = "/ping"
  }
}

resource "aws_lb_target_group" "uc-green-mesh-tg" {
  name        = "uc-green-mesh-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.appmesh-vpc.id

  health_check {
    path = "/ping"
  }
}

resource "aws_lb_target_group" "uc-pilot-mesh-tg" {
  name        = "uc-pilot-mesh-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.appmesh-vpc.id

  health_check {
    path = "/ping"
  }
}

resource "aws_lb_target_group" "uc-grafana-tg" {
  name        = "uc-grafana-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.appmesh-vpc.id

  health_check {
    path = "/api/health"
  }
}
