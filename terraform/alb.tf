resource "aws_lb_listener" "uc-mesh-listener-prod" {
  load_balancer_arn = aws_lb.prod-uc-mesh-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    forward {
        target_group {
            arn = aws_lb_target_group.uc-blue-mesh-tg.arn
            weight = 1
        }
        target_group {
            arn = aws_lb_target_group.uc-green-mesh-tg.arn
            weight = 1
        }
        stickiness {
          duration = 1
        }
    }
  }
}

resource "aws_lb_listener" "uc-mesh-listener-pilot" {
  load_balancer_arn = aws_lb.pilot-uc-mesh-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.uc-pilot-mesh-tg.arn
  }
}

resource "aws_lb_listener" "uc-grafana" {
  load_balancer_arn = aws_lb.uc-grafana-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.uc-grafana-tg.arn
  }
}
