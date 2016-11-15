#!/bin/sh

gcloud compute disks create \
	--project "ninneman-cvdev" \
	--zone "us-central1-a" \
	--size 200GB \
	mongo-disk

# Setup MongoDB
echo "Creating MongoDB deployment/service"
kubectl create -f mongo_deployment.yml
kubectl create -f mongo_service.yml
kubectl get svc,deployment

# Setup the Application
# First, we build the docker image
cd app/
echo "Building docker image"
docker build -t gcr.io/ninneman_cvdev/app:v1 .
echo "Pushing to Google Container Registry"
gcloud docker push gcr.io/ninneman_cvdev/app


# create the kubernetes resources
cd ../
echo "Creating application deployment/service"
kubectl create -f app_deployment.yml
kubectl create -f app_service.yml

kubectl get svc,deployment
