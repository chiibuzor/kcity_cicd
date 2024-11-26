#!/bin/bash
set -e

APP_TYPE=$1
BUCKET_NAME=$2
REGION=$3

if [[ $APP_TYPE == "react" ]]; then
  BUILD_DIR="react-app/build"
elif [[ $APP_TYPE == "svelte" ]]; then
  BUILD_DIR="svelte-app/public"
else
  echo "Invalid frontend type. Exiting."
  exit 1
fi

echo "Deploying $APP_TYPE frontend to S3 bucket $BUCKET_NAME in region $REGION..."
aws s3 sync $BUILD_DIR s3://$BUCKET_NAME --region $REGION --delete
