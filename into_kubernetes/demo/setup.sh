#!/bin/sh

# Clean-up from a possible previous run
kubectl delete -f mongo_deployment.yml
kubectl delete -f mongo_service.yml
kubectl delete -f app_deployment.yml
kubectl delete -f app_service.yml

gcloud compute disks delete -q \
	--project "ninneman-cvdev" \
	--zone "us-central1-a" \
	mongo-disk

gcloud compute disks create \
	--project "ninneman-cvdev" \
	--zone "us-central1-a" \
	--size 200GB \
	mongo-disk

# Setup MongoDB
echo "Creating MongoDB deployment/service"
kubectl create -f mongo_deployment.yml
kubectl create -f mongo_service.yml
kubectl get svc,rc

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

kubectl get svc,deployment,rc
