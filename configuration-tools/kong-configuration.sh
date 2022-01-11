#!/bin/sh
if [ "$#" -ne 1 ]
then
  echo "Usage: Must supply a Kong IP"
  exit 1
fi

KONG_IP=$1
# Create Service
curl -d "name=advisor-api&url=http://advisor-api.uc-mesh.local:8080/" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://${KONG_IP}:8001/services/
SERVICE_ID=$(curl -s ${KONG_IP}:8001/services | jq -r '.data[0].id')

# Passthrough trace header
curl -s -d "name=correlation-id&config.header_name=x-client-trace-id&config.generator=uuid#counter&config.echo_downstream=false" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://${KONG_IP}:8001/services/${SERVICE_ID}/plugins

# Routes
curl -s -d "paths[]=/service&name=service&strip_path=false" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://${KONG_IP}:8001/services/${SERVICE_ID}/routes
curl -s -d "paths[]=/ping&name=ping&strip_path=false" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://${KONG_IP}:8001/services/${SERVICE_ID}/routes
