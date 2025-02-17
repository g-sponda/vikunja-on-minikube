#!/bin/bash

# First let's provision k8s cluster locally, I will be using minikube for that.
# Let's set a High Available minikube k8s cluster, the idea here is to have something near
# to a real cluster
minikube start --ha --driver=docker --container-runtime=containerd
# I set containerd as the container-runtime, since k8s has dropped official support to docker since version 1.24.

# We will create the secret for our DB, this is to be simple and easier to implement, in a real case scenario,
# the ideal aproach would be to have the secrets saved in a secrets management, like Hashicorp Vault,
# AWS SecretsManager, GCP SecretManager
kubectl create secret generic vikunja-db-secret

# Enable Metrics Server for HPA
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# For some observability, let's install prometheus + grafana
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install monitoring prometheus-community/kube-prometheus-stack

# Let's install our vikunja-chart
helm install vikunja ./vikunja-helm-chart
