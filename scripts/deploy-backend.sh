#!/bin/bash
set -e

REGION=${1:-'me-central-1'}

echo "Deploying backend services to ECS cluster in region $REGION..."
aws ecs update-service \
    --cluster backend-cluster \
    --service backend-service \
    --force-new-deployment \
    --region $REGION
