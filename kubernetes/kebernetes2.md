# Kubernetes: ConfigMaps, Secrets, Volumes, & Rolling Updates

A guide to managing configuration, sensitive data, storage, and application updates in Kubernetes.

---

## ConfigMaps

ConfigMaps are Kubernetes objects used to store non-sensitive configuration data as key-value pairs. They are essential for decoupling configuration from container images, which makes applications more portable.

### Creating ConfigMaps

You can create ConfigMaps in several ways:
* **From literal values**: Using the `kubectl create configmap --from-literal` command to define key-value pairs directly.
* **From files**: Using `kubectl create configmap --from-file` to create a ConfigMap from the contents of a single file or a directory of files.
* **From a YAML manifest**: Defining the key-value data directly in a YAML file under the `data` field.

### Using ConfigMaps in Pods

ConfigMaps can be consumed by Pods in two primary ways:
* **As Environment Variables**: You can inject key-value pairs from a ConfigMap directly into a container as environment variables.
* **As Volume Mounts**: You can mount a ConfigMap as a volume, where each key in the ConfigMap becomes a file in the specified mount path.

---

## Secrets

Secrets are similar to ConfigMaps but are specifically designed to hold sensitive information like passwords, API tokens, or TLS certificates. The data is stored in a base64 encoded format.

### Creating Secrets

* **Imperatively**: Using `kubectl create secret` for different types, such as `generic`, `docker-registry` (for private container images), or `tls`.
* **Declaratively**: Using a YAML manifest. You can provide base64 encoded values in the `data` field or plain text values in the `stringData` field, which Kubernetes will automatically encode.

### Using Secrets in Pods

Like ConfigMaps, Secrets can be exposed to containers:
* **As Environment Variables**: Injecting secret data as environment variables for the application to use.
* **As Volume Mounts**: Mounting a secret as a read-only volume, where each key becomes a file inside the container.
* **As Image Pull Secrets**: Using `imagePullSecrets` in a Pod specification to allow it to pull container images from a private registry.

---

## Volumes

Kubernetes Volumes provide a way to manage storage for containers, ensuring that data can persist beyond the lifecycle of a single pod.

### Common Volume Types

* **`emptyDir`**: A temporary volume that is created when a Pod is assigned to a node and exists as long as that Pod is running. It is useful for sharing data between containers within the same Pod.
* **`hostPath`**: Mounts a file or directory from the host node’s filesystem into a Pod. This should be used with caution as it can create security risks.
* **`persistentVolume` (PV) and `persistentVolumeClaim` (PVC)**: This is the standard model for managing durable storage.
    * A **PersistentVolume (PV)** is a piece of storage in the cluster that has been provisioned by an administrator.
    * A **PersistentVolumeClaim (PVC)** is a request for storage by a user, which is then bound to a suitable PV. Pods consume persistent storage by referencing the PVC.

---

## Rolling Updates

Rolling updates are the default strategy used by Kubernetes Deployments to update applications with zero downtime. This is achieved by incrementally replacing old pods with new ones.

### Configuring Rolling Updates

The update strategy can be fine-tuned in the Deployment manifest:
* `strategy.rollingUpdate.maxUnavailable`: The maximum number of pods that can be unavailable during an update.
* `strategy.rollingUpdate.maxSurge`: The maximum number of new pods that can be created above the desired replica count during an update.

### Performing and Managing Rollouts

* **Triggering an Update**: A rollout is typically triggered by changing the container image version in the Deployment template using `kubectl set image`.
* **Monitoring a Rollout**: You can check the progress of an update using `kubectl rollout status deployment/<deployment-name>`.
* **Managing History and Rollbacks**: Kubernetes keeps a history of deployment revisions. You can view this with `kubectl rollout history` and revert to a previous version using `kubectl rollout undo`.
* **Health Checks**: `readinessProbe` and `livenessProbe` are critical for safe rolling updates. They ensure that traffic is only sent to new pods when they are ready to handle it and that failing pods are restarted.