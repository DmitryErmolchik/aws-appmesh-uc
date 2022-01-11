resource "aws_lb" "prod-uc-mesh-alb" {
  name               = "prod-uc-mesh-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.appmesh-allow-all.id ]
  subnets            = [ aws_subnet.appmesh-subnet-1.id, aws_subnet.appmesh-subnet-2.id ]

  enable_deletion_protection = false
}

resource "aws_lb" "pilot-uc-mesh-alb" {
  name               = "pilot-uc-mesh-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.appmesh-allow-all.id ]
  subnets            = [ aws_subnet.appmesh-subnet-1.id, aws_subnet.appmesh-subnet-2.id ]

  enable_deletion_protection = false
}

resource "aws_lb" "uc-grafana-alb" {
  name               = "uc-grafana-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.appmesh-allow-all.id ]
  subnets            = [ aws_subnet.appmesh-subnet-1.id, aws_subnet.appmesh-subnet-2.id ]

  enable_deletion_protection = false
}