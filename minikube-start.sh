#!/bin/bash

shopt -s expand_aliases
source ~/.bashrc
alias kubectl="minikube kubectl --"


minikube start


#Addons
minikube image load k8s.gcr.io/ingress-nginx/controller:v1.9.4
minikube addons enable ingress
minikube addons enable dashboard
minikube addons enable metrics-server

#Docker Image
minikube image load balieiro/devops-webapp:latest
minikube image load mongo
minikube image load mongo-express

#Dashboard
echo | minikube dashboard &

#MongoDB
kubectl apply -f database/configmap.yaml
kubectl apply -f database/secret.yaml
kubectl apply -f database/deployment.yaml
kubectl apply -f database/service.yaml

#MongoExpress
kubectl apply -f express/deployment.yaml
kubectl apply -f express/service.yaml

#Web
kubectl apply -f web/deployment.yaml
kubectl apply -f web/service.yaml

#Ingress
kubectl apply -f ingress.yaml

