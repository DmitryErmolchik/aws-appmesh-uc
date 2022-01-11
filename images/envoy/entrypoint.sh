#!/bin/bash

# $1=Secret Name
getSecret() {
    aws secretsmanager get-secret-value --secret-id $2 --region $AWS_DEFAULT_REGION | jq -r .SecretString > /keys/${1}.pem
    echo "Added $1 to container"
}

getCertificates() {
    if [[ ! -z "$ROOT_CERTIFICATE" ]];
    then
        getSecret "ca_cert" "$ROOT_CERTIFICATE"
    fi

    if [[ ! -z "$NODE_CERTIFICATE_KEY" ]];
    then
        getSecret "node_cert_key" "$NODE_CERTIFICATE_KEY"
    fi

    if [[ ! -z "$NODE_CERTIFICATE_CHAIN" ]];
    then
        getSecret "node_cert_chain" "$NODE_CERTIFICATE_CHAIN"
    fi
}

# Get the appropriate certificates
getCertificates
# Start Envoy
/usr/bin/envoy-wrapper