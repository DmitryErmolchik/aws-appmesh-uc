#!/bin/sh
terraform -chdir=./terraform init
terraform -chdir=./terraform apply -auto-approve

terraform/kong-scripts/run-uc-blue-kong-bootstrap.sh
terraform/kong-scripts/run-uc-green-kong-bootstrap.sh

# Login
AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')
AWS_REGION=$(cat ~/.aws/config | grep region | cut -d " " -f3)


aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# Custom Envoy
ENVOY_REPO=$(echo aws_ecr_repository.aws-mesh-envoy.repository_url | terraform -chdir=./terraform console | tr -d '"')
echo ${ENVOY_REPO}:v1.20.0.1-prod
(cd images/envoy; docker build -f Dockerfile --build-arg ENVOY_IMAGE=public.ecr.aws/appmesh/aws-appmesh-envoy:v1.20.0.1-prod -t ${ENVOY_REPO}:v1.20.0.1-prod .)
docker push ${ENVOY_REPO}:v1.20.0.1-prod

# Custom Open Telemetry Agent
OTEL_REPO=$(echo aws_ecr_repository.aws-mesh-otel-agent.repository_url | terraform -chdir=./terraform console | tr -d '"')
echo ${OTEL_REPO}:0.15.1
(cd images/otel; docker build -f Dockerfile --build-arg OTEL_IMAGE=public.ecr.aws/aws-observability/aws-otel-collector:v0.15.1 -t ${OTEL_REPO}:0.15.1 .)
docker push ${OTEL_REPO}:0.15.1

# Service image
SERVICE_REPO=$(echo aws_ecr_repository.aws-mesh-service.repository_url | terraform -chdir=./terraform console | tr -d '"')
echo ${SERVICE_REPO}:1.0.0
(cd images/service; docker build -f Dockerfile.native -t ${SERVICE_REPO}:1.0.0 .)
docker push ${SERVICE_REPO}:1.0.0


printf "\nGrafana default username/password is admin/admin\n\n"

echo Data to configure Prometheus datasource in Grafana
echo Prometheus Endpoint: $(echo aws_prometheus_workspace.uc-appmesh.prometheus_endpoint | terraform -chdir=./terraform console | tr -d '"')
echo Access Key ID: $(echo aws_iam_access_key.prometheus-query-user.id | terraform -chdir=./terraform console | tr -d '"')
echo Secret Access Key: $(echo "nonsensitive(aws_iam_access_key.prometheus-query-user.secret)" | terraform -chdir=./terraform console | tr -d '"')

printf "\nLoad balancer to call sevice is:\n"
echo $(echo aws_lb.prod-uc-mesh-alb.dns_name | terraform -chdir=./terraform console | tr -d '"')