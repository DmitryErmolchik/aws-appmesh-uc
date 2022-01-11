# Blue
resource "aws_cloudwatch_log_group" "uc-blue-gateway" {
  name = "/ecs/Gateway-UC-Blue"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "uc-blue-kong" {
  name = "/ecs/Kong-UC-Blue"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "uc-blue-advisor-api" {
  name = "/ecs/Advisor-API-UC-Blue"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "uc-blue-fla" {
  name = "/ecs/FLA-UC-Blue"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "uc-blue-masstrans" {
  name = "/ecs/Masstrans-UC-Blue"
  retention_in_days = 1
}

# Green
resource "aws_cloudwatch_log_group" "uc-green-gateway" {
  name = "/ecs/Gateway-UC-Green"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "uc-green-kong" {
  name = "/ecs/Kong-UC-Green"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "uc-green-advisor-api" {
  name = "/ecs/Advisor-API-UC-Green"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "uc-green-fla" {
  name = "/ecs/FLA-UC-Green"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "uc-green-masstrans" {
  name = "/ecs/Masstrans-UC-Green"
  retention_in_days = 1
}

# Tools
resource "aws_cloudwatch_log_group" "uc-tools" {
  name = "/ecs/UC-Tools"
  retention_in_days = 1
}