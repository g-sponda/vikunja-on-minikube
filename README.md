# vikunja-on-minikube

This project helps you set up a Minikube cluster and deploy the Vikunja ToDo List application, along with Prometheus monitoring.

### Requirements

To run this project properly, ensure the following tools are installed on your machine:

- **docker**
- **minikube**
- **kubectl**
- **helm**

If you're using macOS, it may be helpful to install [docker-mac-net-connect](https://github.com/chipmk/docker-mac-net-connect) to resolve networking issues.

### Makefile Overview

The project includes a Makefile to simplify various tasks:

- **Create Minikube Cluster**: Set up a Minikube cluster with Ingress and metrics-server addons.
- **Install Prometheus**: Deploy the Prometheus-operator for cluster monitoring.
- **Install Vikunja**: Install the Vikunja ToDo List application using Helm.
- **Clean Up**: Uninstall all services and destroy the Minikube cluster.

### How to Use

Follow these steps to set up your environment:

1. **Create the Minikube cluster with Ingress and metrics-server**:

   ```
   make create-cluster
   ```

2. **Install Prometheus for monitoring**:

   ```
   make install-prometheus
   ```

3. **Install Vikunja using Helm**:

   ```
   make install-vikunja
   ```

4. **To clean up the setup, destroy the Minikube cluster and uninstall services**:

   ```
   make clean
   ```

### Available Makefile Targets

- `create-cluster`: Creates and configures a Minikube cluster with Ingress and metrics-server.
- `install-prometheus`: Installs Prometheus-operator for monitoring.
- `install-vikunja`: Deploys Vikunja using Helm.
- `uninstall-all`: Uninstalls Vikunja and Prometheus and deletes associated resources.
- `destroy`: Deletes the Minikube cluster.
- `clean`: Cleans up the entire setup, including uninstalling services and destroying the cluster.
