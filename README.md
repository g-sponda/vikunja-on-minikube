# This is a DevOps case study for Distribusion

_Task:_ Todo App
Scenario: You have been given the Vikunja ToDo List application (link), a microservices-based app that consists of three services: frontend, backend, and database. Your task is to automate the deployment of this application using Kubernetes, optimize the network configuration for performance and reliability, consider the deployment strategy for the database service, and optionally implement Identity and Access Management (IAM) using Keycloak for secure authentication and authorisation.

_Requirements:_

- Set up a Kubernetes cluster (you can use a local tool like Minikube or a cloud-based service like GKE, EKS, or AKS).
- Consider using deployment templating tools like Helm, Kustomize, Jsonnet, or similar, for managing Kubernetes manifests and configurations. Explain your choice.
- Create YAML manifests for deploying the three services (frontend, backend, database) in Kubernetes using your chosen deployment templating tool.
- Consider whether the database service should be self-hosted or managed (e.g., self-hosted PostgreSQL vs. managed database service like AWS RDS or Google Cloud SQL). Justify your choice.
- Optionally, implement Identity and Access Management (IAM) for secure authentication and authorization using Keycloak.
- Ensure that the Vikunja ToDo List application is highly available and resilient to failures.
- Implement and configure a load balancer to distribute traffic across the services.
- Optimize the network settings for low latency and high throughput.
- Use any necessary tools or configurations to monitor and debug the application.

_Evaluation Criteria:_

- Proper usage of Kubernetes resources (Deployments, Services, Pods, etc.) through your chosen deployment templating tool.
- Efficient resource utilization (e.g., defining resource limits and requests).
- Implementation of health checks and readiness probes for services.
- Effective use of deployment templating tool for configuration management.
- Demonstrated knowledge of network optimization techniques.
- Justification and implementation of database deployment strategy (self-hosted vs. managed).
- Optional: Correct implementation of Identity and Access Management using Keycloak for secure authentication and authorization.

_Deliverables:_

- YAML manifests for deploying the services (frontend.yaml, backend.yaml, database.yaml) using your chosen deployment templating tool.
- Explain your choice of using the deployment templating tool, and how it was leveraged for configuration management.
- A brief documentation explaining your design decisions, any optimizations made, the justification for the database deployment strategy, and optionally, details on Keycloak IAM setup.
- Optional: A script or automation tool for monitoring or troubleshooting the Vikunja ToDo List application.
