# Kubernetes Command Reference

A practical guide to essential `kubectl` commands for managing applications, configuration, storage, and troubleshooting.

---

## Managing Workloads (Deployments, Pods, etc.)

### ### Applying & Creating Resources
* **`kubectl apply -f <filename.yaml>`**: Creates or updates resources from a YAML manifest file.
* **`kubectl run <pod-name> --image=<image-name>`**: Creates and runs a single pod quickly (useful for testing).

### ### Getting Information
* **`kubectl get pods`**: Lists all pods in the current namespace.
* **`kubectl get deployments`**: Lists all deployments.
* **`kubectl get services`**: Lists all services.
* **`kubectl get all`**: Lists all major resources (pods, services, deployments, etc.) in the current namespace.
* **`kubectl get pods -o wide`**: Lists pods with more detailed information, including the node they are on and their IP address.
* **`kubectl get pods -n <namespace-name>`**: Lists pods in a specific namespace.

### ### Describing & Deleting Resources
* **`kubectl describe pod <pod-name>`**: Shows detailed information about a pod, including its configuration, status, and recent events.
* **`kubectl describe deployment <deployment-name>`**: Shows detailed information about a deployment.
* **`kubectl delete pod <pod-name>`**: Deletes a specific pod.
* **`kubectl delete -f <filename.yaml>`**: Deletes all resources defined in a specific YAML file.

---

## Managing Updates & Rollouts

### ### Updating & Scaling
* **`kubectl scale deployment <deployment-name> --replicas=<count>`**: Scales the number of pods in a deployment.
* **`kubectl set image deployment/<dep-name> <container-name>=<new-image>`**: Updates the container image of a deployment, which triggers a rolling update.
* **`kubectl edit deployment <deployment-name>`**: Opens the deployment's manifest in a text editor for manual changes.

### ### Managing Rollouts
* **`kubectl rollout status deployment/<deployment-name>`**: Checks the live status of a rolling update.
* **`kubectl rollout history deployment/<deployment-name>`**: Views the revision history of a deployment's rollouts.
* **`kubectl rollout undo deployment/<deployment-name>`**: Rolls back a deployment to its previous version.
* **`kubectl rollout undo deployment/<deployment-name> --to-revision=<number>`**: Rolls back a deployment to a specific revision number.
* **`kubectl rollout restart deployment/<deployment-name>`**: Performs a rolling restart of all pods in a deployment, which is useful for forcing a configuration reload.
* **`kubectl rollout pause deployment/<deployment-name>`**: Pauses an ongoing rollout.
* **`kubectl rollout resume deployment/<deployment-name>`**: Resumes a paused rollout.

---

## Debugging & Interaction

* **`kubectl logs <pod-name>`**: Displays the logs from the primary container in a pod.
* **`kubectl logs -f <pod-name>`**: Streams the logs from a pod in real-time (follow).
* **`kubectl logs <pod-name> -c <container-name>`**: Displays logs from a specific container within a multi-container pod.
* **`kubectl exec -it <pod-name> -- /bin/bash`**: Opens an interactive shell session inside a running pod.
* **`kubectl get events --sort-by=.metadata.creationTimestamp`**: Shows a log of recent cluster events, sorted by time.
* **`kubectl port-forward <pod-or-service-name> <local-port>:<remote-port>`**: Forwards a local port to a port on a pod or service for direct access.

---

## Managing Configuration & Secrets

* **`kubectl get configmaps`**: Lists all ConfigMaps.
* **`kubectl create configmap <name> --from-literal=<key>=<value>`**: Creates a ConfigMap from key-value pairs specified on the command line.
* **`kubectl create configmap <name> --from-file=<path/to/file>`**: Creates a ConfigMap from one or more files.
* **`kubectl get secrets`**: Lists all Secrets.
* **`kubectl create secret generic <name> --from-literal=<key>=<value>`**: Creates a generic secret from key-value pairs.
* **`kubectl create secret docker-registry <name> --docker-server=...`**: Creates a secret for authenticating with a private Docker registry.

---

## Managing Storage & Networking

### ### Storage
* **`kubectl get pv`**: Lists all PersistentVolumes.
* **`kubectl get pvc`**: Lists all PersistentVolumeClaims.
* **`kubectl describe pvc <pvc-name>`**: Shows detailed information about a PersistentVolumeClaim and its status.
* **`kubectl get storageclass`**: Lists the available StorageClasses for dynamic volume provisioning.

### ### Networking
* **`kubectl get services`**: Lists all services in the cluster.
* **`kubectl describe service <service-name>`**: Shows detailed information about a service, including its IP and ports.
* **`kubectl get endpoints <service-name>`**: Shows the internal IP addresses and ports of the pods that a service is currently routing traffic to.