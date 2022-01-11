#!/bin/sh
aws ecs run-task \
--task-definition arn:aws:ecs:us-east-1:522204986538:task-definition/uc-green-kong-migration:13 \
--cluster arn:aws:ecs:us-east-1:522204986538:cluster/uc-green \
--network-configuration "{ \"awsvpcConfiguration\": { \"subnets\": [ \"subnet-04a94668bdf66e6d7\", \"subnet-06f6fd8243f53bcbd\" ], \"securityGroups\": [ \"sg-0a322efb47727cdbc\" ], \"assignPublicIp\": \"ENABLED\" } }" \
--launch-type FARGATE
