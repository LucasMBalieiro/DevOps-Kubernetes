#!/bin/bash

shopt -s expand_aliases
source ~/.bashrc
alias kubectl="minikube kubectl --"

#Ingress
kubectl delete -f ingress.yaml

#Web
kubectl delete -f web/service.yaml
kubectl delete -f web/deployment.yaml

#MongoExpress
kubectl delete -f express/service.yaml
kubectl delete -f express/deployment.yaml

#MongoDB
kubectl delete -f database/service.yaml
kubectl delete -f database/deployment.yaml
kubectl delete -f database/secret.yaml
kubectl delete -f database/configmap.yaml


minikube stop