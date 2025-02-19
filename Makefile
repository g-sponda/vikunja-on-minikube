# Makefile for Vikunja deployment on Minikube

# Phony targets (targets that don't represent files)
.PHONY: all create-cluster install-deps install-vikunja destroy clean uninstall

# Variables
DEFAULT_K8S_NAMESPACE := default
VIKUNJA_DB_SECRET_NAME := vikunja-db-secret
HELM_TIMEOUT := 600s

# Main target
all: create-cluster install-deps install-vikunja

# Create Minikube cluster
# Let's set a High Available minikube k8s cluster, the idea here is to have something near
# to a real cluster
# I set containerd as the container-runtime, since k8s has dropped official support to docker since version 1.24.
create-cluster:
	@echo "Creating Minikube cluster..."
	minikube start --ha --driver=docker --container-runtime=containerd --addons=ingress --addons=metrics-server
	minikube addons enable ingress 
	minikube addons enable metrics-server

# Install all
install-all: install-prometheus install-vikunja

# Install Prometheus
# For some observability, let's install prometheus + grafana
install-prometheus:
	@echo "Installing Prometheus..."
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update
	helm install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  --set prometheus.serviceMonitor.enabled=true \
	--set prometheus.prometheusSpec.ruleSelectorNilUsesHelmValues=false \
  --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
  --set prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues=false \
  --set prometheus.prometheusSpec.probeSelectorNilUsesHelmValues=false \
  --set prometheus.prometheusSpec.scrapeConfigSelectorNilUsesHelmValues=false \
  --set global.scrape_interval="15s" \
	--timeout $(HELM_TIMEOUT)

# Install Vikunja dependencies
# We will create the secret for our DB, this is to be simple and easier to implement, in a real case scenario,
# the ideal aproach would be to have the secrets saved in a secrets management, like Hashicorp Vault,
# AWS SecretsManager, GCP SecretManager
install-vikunja-deps:
	@echo "Installing Vikunja dependencies..."
	-kubectl create secret generic $(VIKUNJA_DB_SECRET_NAME) --namespace $(DEFAULT_K8S_NAMESPACE) --save-config
	helm dependency update ./helm/vikunja-chart

# Install Vikunja
install-vikunja: install-vikunja-deps
	@echo "Installing Vikunja..."
	helm install vikunja ./helm/vikunja-chart --namespace $(DEFAULT_K8S_NAMESPACE) --timeout $(HELM_TIMEOUT) --set database.secretName=$(VIKUNJA_DB_SECRET_NAME)

# Help to Create user without needing to enter the container.
vikunja-user-create-admin:
	kubectl exec -n $(DEFAULT_K8S_NAMESPACE) deploy/vikunja-backend -- /app/vikunja/vikunja user create --email admin@admin.co --username admin --password admin

# Upgrade Vikunja
upgrade-vikunja:
	@echo "Updating Vikunja"
	helm upgrade vikunja ./helm/vikunja-chart --namespace $(DEFAULT_K8S_NAMESPACE) --timeout $(HELM_TIMEOUT) --set database.secretName=$(VIKUNJA_DB_SECRET_NAME) 

# Uninstall all resources
uninstall-all: uninstall-vikunja uninstall-prometheus

# Uninstall Vikunja
uninstall-vikunja:
	@echo "Uninstalling Vikunja..."
	-helm uninstall vikunja --namespace $(DEFAULT_K8S_NAMESPACE)
	kubectl delete secret vikunja-db-secret --namespace $(DEFAULT_K8S_NAMESPACE)

# Uninstall Prometheus
uninstall-prometheus:
	@echo "Uninstalling Prometheus..."
	helm uninstall monitoring --namespace monitoring

# Destroy Minikube cluster
destroy:
	@echo "Destroying Minikube cluster..."
	minikube delete 

# Clean up (destroy cluster and remove any leftover files)
clean: uninstall destroy
	@echo "Cleaning up..."
