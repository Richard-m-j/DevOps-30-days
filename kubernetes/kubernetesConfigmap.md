# Kubernetes Commands: Config, Storage & Updates

A reference for `kubectl` commands related to managing ConfigMaps, Secrets, Volumes, and Rolling Updates.

---

## Managing Configuration (ConfigMaps & Secrets)

### ConfigMaps

- **`kubectl get configmaps`**: Lists all ConfigMaps in the current namespace.
- **`kubectl describe configmap <configmap-name>`**: Shows the data and details of a specific ConfigMap.
- **`kubectl create configmap <name> --from-literal=<key>=<value>`**: Creates a new ConfigMap from a key-value pair provided on the command line.
- **`kubectl create configmap <name> --from-file=<path/to/file.conf>`**: Creates a new ConfigMap from a file.
- **`kubectl create configmap <name> --from-file=<path/to/directory>`**: Creates a new ConfigMap with keys for each file in a directory.

### Secrets

- **`kubectl get secrets`**: Lists all Secrets in the current namespace.
- **`kubectl describe secret <secret-name>`**: Shows the metadata of a Secret (the values are not displayed).
- **`kubectl create secret generic <name> --from-literal=<key>=<value>`**: Creates a generic Secret from a key-value pair.
- **`kubectl create secret generic <name> --from-file=<path/to/file>`**: Creates a generic Secret from a file.
- **`kubectl create secret docker-registry <name> --docker-server=...`**: Creates a Secret used for authenticating with a private Docker registry to pull images.
- **`kubectl create secret tls <name> --cert=<path/to/cert> --key=<path/to/key>`**: Creates a TLS Secret from a certificate and private key.

---

## Managing Storage (Volumes)

- **`kubectl get pv`**: Lists all PersistentVolumes in the cluster.
- **`kubectl describe pv <pv-name>`**: Shows detailed information about a PersistentVolume.
- **`kubectl get pvc`**: Lists all PersistentVolumeClaims in the current namespace.
- **`kubectl describe pvc <pvc-name>`**: Shows detailed information about a PersistentVolumeClaim, including which PV it is bound to.
- **`kubectl get storageclass`**: Lists the available StorageClasses that can be used for dynamic volume provisioning.

---

## Managing Application Updates (Rolling Updates)

### Triggering & Managing Rollouts

- **`kubectl set image deployment/<dep-name> <container-name>=<new-image>`**: Updates the container image of a deployment, triggering a rolling update.
- **`kubectl set env deployment/<dep-name> <KEY>=<VALUE>`**: Sets or updates an environment variable on a deployment, which also triggers a rollout.
- **`kubectl rollout status deployment/<deployment-name>`**: Checks the live status of a rolling update.
- **`kubectl rollout history deployment/<deployment-name>`**: Views the revision history of a deployment's rollouts.
- **`kubectl rollout undo deployment/<deployment-name>`**: Rolls back a deployment to its previous version.
- **`kubectl rollout undo deployment/<deployment-name> --to-revision=<number>`**: Rolls back a deployment to a specific revision number from its history.
- **`kubectl rollout restart deployment/<deployment-name>`**: Performs a rolling restart of all pods in a deployment, which is a common way to force a configuration reload.

### Controlling Rollouts

- **`kubectl rollout pause deployment/<deployment-name>`**: Pauses an ongoing rollout, allowing you to make multiple changes before resuming.
- **`kubectl rollout resume deployment/<deployment-name>`**: Resumes a paused rollout.
- **`kubectl patch deployment <deployment-name> -p '...'`**: Directly modifies a live deployment object, for example, to add an annotation that triggers a restart.

---

## General Troubleshooting Commands

- **`kubectl get pods -w`**: Watches for changes to pods in real-time, useful for observing a rolling update.
- **`kubectl get deployment <deployment-name> -o yaml`**: Outputs the full YAML configuration of a live deployment.
- **`kubectl describe replicaset <replicaset-name>`**: Inspects a ReplicaSet, which is often useful for debugging why pods aren't being created during a rollout.
- **`kubectl delete pod <pod-name-with-old-replicaset>`**: Manually deletes an old pod to speed up a stuck rollout (use with caution).
- **`kubectl scale deployment <deployment-name> --replicas=0`**: Scales a deployment down to zero pods.