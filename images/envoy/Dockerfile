#FROM public.ecr.aws/appmesh/aws-appmesh-envoy:v1.20.0.1-prod
ARG ENVOY_IMAGE
FROM ${ENVOY_IMAGE}

ARG AWS_DEFAULT_REGION

RUN yum update -y && \
    yum install -y jq curl unzip less && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rpm -e --nodeps unzip && \
    rm -rf awscliv2.zip ./aws/install && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN mkdir /keys && chown 1337:1337 /keys 

ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
COPY ./entrypoint.sh /bin/entrypoint.sh
RUN chmod 777 /bin/entrypoint.sh

CMD ["/bin/entrypoint.sh"]
