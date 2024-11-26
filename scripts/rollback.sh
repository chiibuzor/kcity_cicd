#!/bin/bash
set -e

echo "Rolling back to previous stable deployment..."
# Example: Revert ECS service to previous task definition
PREVIOUS_TASK_DEF=$(aws ecs describe-services \
    --cluster backend-cluster \
    --services backend-service \
    --query 'services[0].deployments[1].taskDefinition' \
    --output text)

aws ecs update-service \
    --cluster backend-cluster \
    --service backend-service \
    --task-definition $PREVIOUS_TASK_DEF \
    --region me-central-1
