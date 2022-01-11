# How to install
- You need Linix machine with terraform and pre-configured aws-cli
- Run **run.sh** to create AWS environment, build images and deploy them.
- Find kong ip address and run **configuration-tools/kong-configuration.sh** script to configure Kong services and routes for each mesh.
- Go to Grafana, and configure Prometheus data source.
- Import dashboard 11022


# How to test:
- Find load balancer address
- Call **/service** endpoint. You should see response like:

```sh
{
    "message": "Service: 'Advisor-API' Color: 'Green' External response: 'BTC-USD: 41808.0' Downstream message -> Service: 'FLA' Color: 'Green' External response: 'BTC-USD: 41799.46' Downstream message -> Service: 'Masstrans' Color: 'Green' External response: 'BTC-USD: 41808.0'"
}
```
or

```sh
{
    "message": "Service: 'Advisor-API' Color: 'Blue' External response: 'BTC-USD: 41922.63' Downstream message -> Service: 'FLA' Color: 'Blue' External response: 'BTC-USD: 41913.92' Downstream message -> Service: 'Masstrans' Color: 'Blue' External response: 'BTC-USD: 41922.63'"
}
```

# References
## Configure AWS CLI
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html


# Push docker image
https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html
