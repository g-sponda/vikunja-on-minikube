# Explanation

This file is intended to explain the decisions took to make the study case.

- I will be using minikube to set up my cluster, and work on my local machine, for this study case. Minikube provides a
  quick local environment, without the Cloud Costs.

The usage of Cloud-managed k8s service (EKS, GKE or AKS) is a better implementation, since the cloud providers set
the clusters with auto-scaling, high availability, and built-in monitoring.

For deployment templating tool I opt to use Helm, since it have a good community backing it, it's one of the most mature tool.
Besides that, it supports State Management, which is a good thing since it Tracks release history and supports rollback.
