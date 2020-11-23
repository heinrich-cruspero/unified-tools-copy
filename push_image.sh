#!/usr/bin/env bash

function help() {
	echo "Not enough arguments supplied..."
	echo
	echo "Usage: $0 version_tag update_latest_prod {true|false} run_migration {true|false}"
	echo
	echo "Example: $0 v1.0.0 true false"
	echo "Example: $0 v1.0.1 false true"
	echo "Example: $0 v1.0.2 true false"
	echo
	exit 1
}

if [ $# -lt 3 ]; then
	help
fi

VERSION_TAG="$1"
UPDATE_PROD="$2"
RUN_MIGRATION="$3"

AWS_REPO_NAME="unified-tools"
AWS_REPO_URL="470123955518.dkr.ecr.us-west-2.amazonaws.com/$AWS_REPO_NAME"

Service="UnifiedTools"
JobsService="UnifiedToolsJobs"
DevTask="DevUnifiedTools"
ProdTask="ProdUnifiedTools"

RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production RACK_ENV=production NODE_ENV=production bin/webpack
docker build . -t $AWS_REPO_NAME

#Tag the old latest_dev with a version
MANIFEST=$(aws ecr batch-get-image --region us-west-2 --profile bba-ecr --repository-name $AWS_REPO_NAME --image-ids imageTag=latest_dev --query 'images[].imageManifest' --output text)
aws ecr put-image --region us-west-2 --profile bba-ecr --repository-name $AWS_REPO_NAME --image-tag $VERSION_TAG --image-manifest "$MANIFEST" >/dev/null

#Push & Deploy latest_dev
docker tag $AWS_REPO_NAME:latest $AWS_REPO_URL:latest_dev
aws ecr get-login-password --region us-west-2 --profile bba-ecr | docker login --username AWS --password-stdin $AWS_REPO_URL:latest_dev && docker push $AWS_REPO_URL:latest_dev
aws ecs update-service --region us-west-2 --profile bba-ecr --cluster Staging --service $Service --force-new-deployment >/dev/null

#Run Migration
if $RUN_MIGRATION ; then
  aws ecs run-task --region us-west-2 --profile bba-ecr --cluster Staging --task-definition $DevTask --launch-type 'FARGATE' --overrides '{"containerOverrides": [{"name": "Web", "command": ["bundle","exec","rake","db:migrate"]}]}' --network-configuration '{"awsvpcConfiguration": {"subnets": ["subnet-7e732a1a", "subnet-7d19680b"], "securityGroups": ["sg-66a9bc00"]}}' >/dev/null
fi

#Push latest_prod
if $UPDATE_PROD ; then
    docker tag $AWS_REPO_NAME:latest $AWS_REPO_URL:latest_prod
    aws ecr get-login-password --region us-west-2 --profile bba-ecr | docker login --username AWS --password-stdin $AWS_REPO_URL:latest_prod && docker push $AWS_REPO_URL:latest_prod
    aws ecs update-service --region us-west-2 --profile bba-ecr --cluster Production --service $Service --force-new-deployment >/dev/null
    aws ecs update-service --region us-west-2 --profile bba-ecr --cluster Production --service $JobsService --force-new-deployment >/dev/null

    if $RUN_MIGRATION ; then
      aws ecs run-task --region us-west-2 --profile bba-ecr --cluster Production --task-definition $ProdTask --launch-type 'FARGATE' --overrides '{"containerOverrides": [{"name": "Web", "command": ["bundle","exec","rake","db:migrate"]}]}' --network-configuration '{"awsvpcConfiguration": {"subnets": ["subnet-6fdaf90b", "subnet-a2e992d4"], "securityGroups": ["sg-63cd231a"]}}' >/dev/null
    fi
fi