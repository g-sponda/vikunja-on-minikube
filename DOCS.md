# Explanation

This file is intended to explain the decisions taken to make the study case.

Minikube will be used to set up the cluster and work on the local machine for this study case. Minikube provides a quick local environment without the cloud costs.

While a cloud-managed Kubernetes service (EKS, GKE, or AKS) would be a more robust solution offering features like auto-scaling, high availability, and built-in monitoring.

For the deployment templating tool, I chose Helm. It is a mature tool with strong community support, and it offers benefits like state management, release history tracking, and rollback support.

In this implementation, StatefulSet was used for PostgreSQL to keep the setup simple and ensure it works smoothly in a local environment.

Given the small-scale workload of this project, a self-hosted database is a practical choice due to its potential cost savings compared to a managed solution. However, for a production environment, a managed database offers several advantages:
Automated Backups: Includes point-in-time recovery and snapshots, reducing the risk of data loss and simplifying disaster recovery.
Monitoring and Alerts: Built-in monitoring provides real-time performance insights, making it easier to detect and resolve issues.
Scalability: Supports both vertical and horizontal scaling with minimal manual intervention.
Replication and Failover: High availability (HA) configurations, such as multi-zone replication, ensure minimal downtime and automatic failover.
Reduced Operational Overhead: Maintenance tasks like backups, scaling, and patching are handled automatically by the managed service.

To ensure high availability for Vikunja, minimal configurations like Horizontal Pod Autoscaling (HPA) and liveness/readiness probes were added:
Liveness probes: Determine whether a container is running and trigger a restart if it’s not functioning correctly.
Readiness probes: Ensure that a container is fully initialized and ready to receive traffic, preventing requests from being sent to an unready container.

The Ingress was configured with session affinity and load balancing, using the "least connections" strategy to distribute traffic efficiently. Additional optimizations were made, such as setting connection timeouts and enabling persistent connections via keep-alive. These measures help reduce latency and improve throughput across the services, ensuring that traffic is distributed efficiently and network performance is optimized.
