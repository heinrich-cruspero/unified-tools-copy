#!/usr/bin/env bash

function help() {
	echo "Not enough arguments supplied..."
	echo
	echo "Usage: $0 version_tag update_latest_prod {true|false}"
	echo
	echo "Example: $0 v1.0.0 true"
	echo "Example: $0 v1.0.0.beta false"
	echo
	exit 1
}

if [ $# -lt 2 ]; then
	help
fi

VERSION_TAG="$1"
UPDATE_PROD="$2"

AWS_REPO_NAME="unified-tools"
AWS_REPO_URL="470123955518.dkr.ecr.us-west-2.amazonaws.com/$AWS_REPO_NAME"

StagingServiceName="DevUnifiedToolsService"
ProductionServiceName="ProdUnifiedToolsService"

RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production RACK_ENV=production NODE_ENV=production bin/webpack
docker build . -t $AWS_REPO_NAME

#Tag the old latest_dev with a version
MANIFEST=$(aws ecr batch-get-image --profile bba-ecr --repository-name $AWS_REPO_NAME --image-ids imageTag=latest_dev --query 'images[].imageManifest' --output text)
aws ecr put-image --profile bba-ecr --repository-name $AWS_REPO_NAME --image-tag $VERSION_TAG --image-manifest "$MANIFEST" >/dev/null

#Push & Deploy latest_dev
docker tag $AWS_REPO_NAME:latest $AWS_REPO_URL:latest_dev
aws ecr get-login-password --profile bba-ecr | docker login --username AWS --password-stdin $AWS_REPO_URL:latest_dev && docker push $AWS_REPO_URL:latest_dev
aws ecs update-service --profile bba-ecr --cluster Staging --service $StagingServiceName --force-new-deployment >/dev/null

#Push latest_prod
if $UPDATE_PROD ; then
    docker tag $AWS_REPO_NAME:latest $AWS_REPO_URL:latest_prod
    aws ecr get-login-password --profile bba-ecr | docker login --username AWS --password-stdin $AWS_REPO_URL:latest_prod && docker push $AWS_REPO_URL:latest_prod
    aws ecs update-service --profile bba-ecr --cluster Production --service $ProductionServiceName --force-new-deployment >/dev/null
fi