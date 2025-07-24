# Kubernetes Core Objects: Detailed Notes

### ## What is Kubernetes?

**Kubernetes** (often abbreviated as **K8s**) is an orchestration system for managing containerized applications across a cluster of machines. While a tool like Docker is used to run containers on a single machine, Kubernetes automates the deployment, scaling, and management of these containers, ensuring they run reliably and recover from failures automatically.

Kubernetes uses **objects** as blueprints to define the desired state of an application. The four most fundamental objects are the Pod, ReplicaSet, Deployment, and Service.

---
### ## 1. Pod

A **Pod** is the smallest and most basic deployable unit in Kubernetes. It acts as a wrapper around one or more tightly coupled containers.

* **Key Concepts**:
    * Pods typically run a single main container, but can run multiple containers that need to work closely together.
    * All containers within a single pod share the same network (IP address) and storage volumes.
    * Pods are considered **ephemeral** or temporary. If a pod fails or is deleted, it is gone permanently and not automatically restarted.

* **Limitations**:
    * Because pods are not restarted on failure and cannot be easily updated without downtime, they are rarely used directly. Instead, they are managed by higher-level objects like Deployments.

---
### ## 2. ReplicaSet

A **ReplicaSet** is a controller whose primary job is to ensure that a specified number of identical pod "replicas" are running at all times.

* **Key Concepts**:
    * It constantly monitors the pods under its management.
    * If a pod fails or is deleted, the ReplicaSet immediately creates a new one to maintain the desired count.
    * It can be used to scale the number of pods up or down by changing its `replicas` field.

* **Limitations**:
    * The main drawback of a ReplicaSet is that it does not support **rolling updates**. To update an application, you must delete the old ReplicaSet and create a new one, which results in downtime.

---
### ## 3. Deployment

A **Deployment** is a higher-level object that manages ReplicaSets and is the most common and recommended way to run applications on Kubernetes. It provides sophisticated features for updating applications without downtime.

* **Key Concepts**:
    * A Deployment manages the entire lifecycle of an application, including creating ReplicaSets, which in turn create pods.
    * **Rolling Updates**: Deployments excel at performing rolling updates. When an update is triggered (e.g., by changing a container image), the Deployment creates a new ReplicaSet and gradually replaces old pods with new ones, ensuring the application remains available throughout the process.
    * **Rollbacks**: If an update causes issues, a Deployment allows you to easily roll back to a previous, stable version of the application.
    * **Health Checks**: Deployments can be configured with **Liveness Probes** (to restart unhealthy pods) and **Readiness Probes** (to ensure traffic is only sent to pods that are ready to receive it).

---
### ## 4. Service

A **Service** provides a stable network endpoint to access a group of pods. It solves the problem that pods have temporary, unreliable IP addresses that can change when they are recreated.

* **Key Concepts**:
    * A Service provides a single, stable IP address and DNS name that can be used to access the application.
    * It acts as a load balancer, distributing network traffic evenly across all the pods that match its selector.

* **Types of Services**:
    * **ClusterIP**: (Default) Exposes the service on an internal IP address that is only reachable from within the Kubernetes cluster. This is ideal for internal communication, such as between a web server and a database.
    * **NodePort**: Exposes the service on a static port on each node in the cluster. This makes the service accessible from outside the cluster and is often used for development or testing purposes.
    * **LoadBalancer**: Creates an external load balancer with a public IP address through a cloud provider (like AWS, GCP, or Azure). This is the standard way to expose an application to the internet.