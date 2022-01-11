#FROM public.ecr.aws/aws-observability/aws-otel-collector:v0.15.1

ARG OTEL_IMAGE
FROM ${OTEL_IMAGE}

COPY otel-agent-config.yaml /etc/ecs/otel-agent-config.yaml
CMD ["--config=/etc/ecs/otel-agent-config.yaml"]
