# Kubernetes Notes: Concepts & Commands

A reference sheet for core Kubernetes concepts and their essential `kubectl` commands.

---

## Core Application Objects

Kubernetes uses objects as blueprints to define the desired state of your application.

### ### 1. Pod

A **Pod** is the smallest and simplest unit in Kubernetes, acting as a wrapper for one or more containers. Containers within a pod share the same network and storage resources. Pods are considered temporary; if a pod fails, it is not automatically restarted.

* **Essential Commands**:
    * `kubectl get pods`: Lists all pods in the current namespace.
    * `kubectl describe pod <pod-name>`: Shows detailed information about a specific pod.
    * `kubectl logs <pod-name>`: Displays the logs from a container in a pod.
    * `kubectl exec -it <pod-name> -- /bin/bash`: Opens an interactive shell inside a running pod.

---

### ### 2. ReplicaSet

A **ReplicaSet** is a controller that ensures a specified number of identical pods (replicas) are running at all times. If a pod fails, the ReplicaSet automatically creates a new one to maintain the desired count.

* **Essential Commands**:
    * `kubectl get replicaset`: Lists all ReplicaSets.
    * `kubectl scale replicaset <replicaset-name> --replicas=<count>`: Changes the number of pods managed by the ReplicaSet.

---

### ### 3. Deployment

A **Deployment** is a higher-level object that manages ReplicaSets and is the standard way to run applications on Kubernetes. It provides sophisticated features for updates and rollbacks. Its key feature is enabling **rolling updates** with zero downtime.

* **Essential Commands**:
    * `kubectl apply -f <filename.yaml>`: Creates or updates resources from a YAML file.
    * `kubectl get deployments`: Lists all deployments.
    * `kubectl set image deployment/<deployment-name> <container-name>=<new-image>`: Updates the container image of a deployment, which triggers a rolling update.
    * `kubectl rollout status deployment/<deployment-name>`: Checks the status of a rolling update.
    * `kubectl rollout history deployment/<deployment-name>`: Views the revision history of a deployment.
    * `kubectl rollout undo deployment/<deployment-name>`: Rolls back a deployment to its previous version.

---

### ### 4. Service

A **Service** provides a single, stable network endpoint (IP address and DNS name) to access a group of pods. It solves the problem of pods having temporary, changing IP addresses and also load-balances traffic among them.

* **Essential Commands**:
    * `kubectl get services`: Lists all services.
    * `kubectl describe service <service-name>`: Shows detailed information about a service.
    * `kubectl get endpoints <service-name>`: Shows the pods that a service is currently routing traffic to.

---

## Configuration & Storage

### ### ConfigMaps & Secrets

* **ConfigMaps** are used to store non-sensitive configuration data as key-value pairs, decoupling configuration from your application code.
* **Secrets** are used for sensitive information like passwords and API keys. The data is stored in a base64 encoded format.
* **Essential Commands**:
    * `kubectl create configmap <name> --from-literal=<key>=<value>`: Creates a ConfigMap from key-value pairs.
    * `kubectl create secret generic <name> --from-literal=<key>=<value>`: Creates a generic secret.
    * `kubectl create secret docker-registry <name> ...`: Creates a secret for pulling images from a private Docker registry.

---

### ### Volumes

**Volumes** provide a way to manage storage for containers, ensuring that data persists beyond the lifecycle of a single pod. The standard way to manage persistent storage is by using `PersistentVolumes` (PVs) and `PersistentVolumeClaims` (PVCs).

* **Essential Commands**:
    * `kubectl get pvc`: Lists all PersistentVolumeClaims.
    * `kubectl describe pvc <pvc-name>`: Shows detailed information about a specific PersistentVolumeClaim.
    * `kubectl get storageclass`: Lists available storage classes for dynamic volume provisioning.