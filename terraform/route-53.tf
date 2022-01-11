resource "aws_route53_zone" "uc-mesh-local" {
  name = "uc-mesh.local"

  vpc {
    vpc_id = aws_vpc.appmesh-vpc.id
  }
}

resource "aws_route53_record" "kong" {
  zone_id = aws_route53_zone.uc-mesh-local.zone_id
  name    = local.kong_service_name
  type    = "A"
  ttl     = "60"
  records = [ "192.168.1.2" ]
}

resource "aws_route53_record" "advisor-api" {
  zone_id = aws_route53_zone.uc-mesh-local.zone_id
  name    = local.advisor_api_service_name
  type    = "A"
  ttl     = "60"
  records = [ "192.168.1.3" ]
}

resource "aws_route53_record" "fla" {
  zone_id = aws_route53_zone.uc-mesh-local.zone_id
  name    = local.fla_service_name
  type    = "A"
  ttl     = "60"
  records = [ "192.168.1.4" ]
}

resource "aws_route53_record" "masstrans" {
  zone_id = aws_route53_zone.uc-mesh-local.zone_id
  name    = local.masstrans_service_name
  type    = "A"
  ttl     = "60"
  records = [ "192.168.1.5" ]
}