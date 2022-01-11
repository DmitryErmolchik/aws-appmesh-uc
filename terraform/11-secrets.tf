# Blue
resource "aws_secretsmanager_secret" "ca-uc-blue-cert" {
  name = "ca-uc-blue-cert"
}

resource "aws_secretsmanager_secret_version" "ca-uc-blue-cert" {
  secret_id     = aws_secretsmanager_secret.ca-uc-blue-cert.id
  secret_string = file("cert/CA-blue/ca_blue_cert.pem")
}

resource "aws_secretsmanager_secret" "gateway-uc-blue-cert-chain" {
  name = "gateway-uc-blue-cert-chain"
}

resource "aws_secretsmanager_secret_version" "gateway-uc-blue-cert-chain" {
  secret_id     = aws_secretsmanager_secret.gateway-uc-blue-cert-chain.id
  secret_string = file("cert/gateway-uc-blue/gateway.uc.blue.mesh.chain.crt")
}


resource "aws_secretsmanager_secret" "gateway-uc-blue-key" {
  name = "gateway-uc-blue-key"
}

resource "aws_secretsmanager_secret_version" "gateway-uc-blue-key" {
  secret_id     = aws_secretsmanager_secret.gateway-uc-blue-key.id
  secret_string = file("cert/gateway-uc-blue/gateway.uc.blue.mesh.key")
}


resource "aws_secretsmanager_secret" "kong-uc-blue-cert-chain" {
  name = "kong-uc-blue-cert-chain"
}

resource "aws_secretsmanager_secret_version" "kong-uc-blue-cert-chain" {
  secret_id     = aws_secretsmanager_secret.kong-uc-blue-cert-chain.id
  secret_string = file("cert/kong-uc-blue/kong.uc.blue.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "kong-uc-blue-key" {
  name = "kong-uc-blue-key"
}

resource "aws_secretsmanager_secret_version" "kong-uc-blue-key" {
  secret_id     = aws_secretsmanager_secret.kong-uc-blue-key.id
  secret_string = file("cert/kong-uc-blue/kong.uc.blue.mesh.key")
}

resource "aws_secretsmanager_secret" "advisor-api-uc-blue-cert-chain" {
  name = format("%s-uc-blue-cert-chain", local.advisor_api_service_name)
}

resource "aws_secretsmanager_secret_version" "advisor-api-uc-blue-cert-chain" {
  secret_id     = aws_secretsmanager_secret.advisor-api-uc-blue-cert-chain.id
  secret_string = file("cert/advisor-api-uc-blue/advisor-api.uc.blue.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "advisor-api-uc-blue-key" {
  name = format("%s-uc-blue-key", local.advisor_api_service_name)
}

resource "aws_secretsmanager_secret_version" "advisor-api-uc-blue-key" {
  secret_id     = aws_secretsmanager_secret.advisor-api-uc-blue-key.id
  secret_string = file("cert/advisor-api-uc-blue/advisor-api.uc.blue.mesh.key")
}

resource "aws_secretsmanager_secret" "fla-uc-blue-cert-chain" {
  name = format("%s-uc-blue-cert-chain", local.fla_service_name)
}

resource "aws_secretsmanager_secret_version" "fla-uc-blue-cert-chain" {
  secret_id     = aws_secretsmanager_secret.fla-uc-blue-cert-chain.id
  secret_string = file("cert/fla-uc-blue/fla.uc.blue.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "fla-uc-blue-key" {
  name = format("%s-uc-blue-key", local.fla_service_name)
}

resource "aws_secretsmanager_secret_version" "fla-uc-blue-key" {
  secret_id     = aws_secretsmanager_secret.fla-uc-blue-key.id
  secret_string = file("cert/fla-uc-blue/fla.uc.blue.mesh.key")
}

resource "aws_secretsmanager_secret" "masstrans-uc-blue-cert-chain" {
  name = format("%s-uc-blue-cert-chain", local.masstrans_service_name)
}

resource "aws_secretsmanager_secret_version" "masstrans-uc-blue-cert-chain" {
  secret_id     = aws_secretsmanager_secret.masstrans-uc-blue-cert-chain.id
  secret_string = file("cert/masstrans-uc-blue/masstrans.uc.blue.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "masstrans-uc-blue-key" {
  name = format("%s-uc-blue-key", local.masstrans_service_name)
}

resource "aws_secretsmanager_secret_version" "masstrans-uc-blue-key" {
  secret_id     = aws_secretsmanager_secret.masstrans-uc-blue-key.id
  secret_string = file("cert/masstrans-uc-blue/masstrans.uc.blue.mesh.key")
}

# Green
resource "aws_secretsmanager_secret" "ca-uc-green-cert" {
  name = "ca-uc-green-cert"
}

resource "aws_secretsmanager_secret_version" "ca-uc-green-cert" {
  secret_id     = aws_secretsmanager_secret.ca-uc-green-cert.id
  secret_string = file("cert/CA-green/ca_green_cert.pem")
}

resource "aws_secretsmanager_secret" "gateway-uc-green-cert-chain" {
  name = "gateway-uc-green-cert-chain"
}

resource "aws_secretsmanager_secret_version" "gateway-uc-green-cert-chain" {
  secret_id     = aws_secretsmanager_secret.gateway-uc-green-cert-chain.id
  secret_string = file("cert/gateway-uc-green/gateway.uc.green.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "gateway-uc-green-key" {
  name = "gateway-uc-green-key"
}

resource "aws_secretsmanager_secret_version" "gateway-uc-green-key" {
  secret_id     = aws_secretsmanager_secret.gateway-uc-green-key.id
  secret_string = file("cert/gateway-uc-green/gateway.uc.green.mesh.key")
}

resource "aws_secretsmanager_secret" "kong-uc-green-cert-chain" {
  name = "kong-uc-green-cert-chain"
}

resource "aws_secretsmanager_secret_version" "kong-uc-green-cert-chain" {
  secret_id     = aws_secretsmanager_secret.kong-uc-green-cert-chain.id
  secret_string = file("cert/kong-uc-green/kong.uc.green.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "kong-uc-green-key" {
  name = "kong-uc-green-key"
}

resource "aws_secretsmanager_secret_version" "kong-uc-green-key" {
  secret_id     = aws_secretsmanager_secret.kong-uc-green-key.id
  secret_string = file("cert/kong-uc-green/kong.uc.green.mesh.key")
}

resource "aws_secretsmanager_secret" "advisor-api-uc-green-cert-chain" {
  name = format("%s-uc-green-cert-chain", local.advisor_api_service_name)
}

resource "aws_secretsmanager_secret_version" "advisor-api-uc-green-cert-chain" {
  secret_id     = aws_secretsmanager_secret.advisor-api-uc-green-cert-chain.id
  secret_string = file("cert/advisor-api-uc-green/advisor-api.uc.green.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "advisor-api-uc-green-key" {
  name = format("%s-uc-green-key", local.advisor_api_service_name)
}

resource "aws_secretsmanager_secret_version" "advisor-api-uc-green-key" {
  secret_id     = aws_secretsmanager_secret.advisor-api-uc-green-key.id
  secret_string = file("cert/advisor-api-uc-green/advisor-api.uc.green.mesh.key")
}

resource "aws_secretsmanager_secret" "fla-uc-green-cert-chain" {
  name = format("%s-uc-green-cert-chain", local.fla_service_name)
}

resource "aws_secretsmanager_secret_version" "fla-uc-green-cert-chain" {
  secret_id     = aws_secretsmanager_secret.fla-uc-green-cert-chain.id
  secret_string = file("cert/fla-uc-green/fla.uc.green.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "fla-uc-green-key" {
  name = format("%s-uc-green-key", local.fla_service_name)
}

resource "aws_secretsmanager_secret_version" "fla-uc-green-key" {
  secret_id     = aws_secretsmanager_secret.fla-uc-green-key.id
  secret_string = file("cert/fla-uc-green/fla.uc.green.mesh.key")
}

resource "aws_secretsmanager_secret" "masstrans-uc-green-cert-chain" {
  name = format("%s-uc-green-cert-chain", local.masstrans_service_name)
}

resource "aws_secretsmanager_secret_version" "masstrans-uc-green-cert-chain" {
  secret_id     = aws_secretsmanager_secret.masstrans-uc-green-cert-chain.id
  secret_string = file("cert/masstrans-uc-green/masstrans.uc.green.mesh.chain.crt")
}

resource "aws_secretsmanager_secret" "masstrans-uc-green-key" {
  name = format("%s-uc-green-key", local.masstrans_service_name)
}

resource "aws_secretsmanager_secret_version" "masstrans-uc-green-key" {
  secret_id     = aws_secretsmanager_secret.masstrans-uc-green-key.id
  secret_string = file("cert/masstrans-uc-green/masstrans.uc.green.mesh.key")
}