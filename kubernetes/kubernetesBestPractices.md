# Kubernetes Manifest Best Practices

The best practices implemented for writing and managing Kubernetes manifests
---

## Manifest Organization & GitOps

* **Repository Structure**: Each microservice's Kubernetes manifests are stored directly within its own source code repository. This keeps the application code and its deployment configuration co-located and versioned together.

* **GitOps with ArgoCD**: The entire application is managed using ArgoCD, which acts as the single source of truth. The desired state of the application is defined declaratively in the Git repositories.

* **Automated CI/CD Pipeline**: A comprehensive CI/CD pipeline is established for each microservice to automate the entire release process from code commit to deployment.
    * **Continuous Integration (CI)**: The CI pipeline automatically triggers the following stages:
        * **Code Quality Checks**: The code is first run through a **linter** to ensure it adheres to style standards and best practices.
        * **Unit Testing**: A suite of **unit tests** is executed to verify that individual components of the code function correctly.
        * **Software Component Analysis (SCA)**: Scans for known vulnerabilities in third-party libraries and dependencies.
        * **Static Application Security Testing (SAST)**: The source code is analyzed using tools like **CodeQL**, **npm audit**, etc to identify potential security flaws and bugs before compilation.
        * **Artifact Creation**: Once all checks pass, a new **Docker container image** is built and **pushed** to Docker Hub.
    * **Continuous Deployment (CD)**: The deployment process is managed by ArgoCD following the GitOps methodology:
        * **Manifest Update**: The pipeline automatically updates the relevant Kubernetes manifest in the Git repository with the new container image tag.
        * **Automated Rollout**: **ArgoCD**, which continuously monitors the Git repository, detects the change in the manifest. It then automatically pulls the new image and rolls out the update to the appropriate microservice in the Kubernetes cluster, ensuring a seamless and fast deployment.


---

## Networking

* **Path-Based Routing with Ingress**: An Ingress controller is configured to manage external access to the services. It uses **path-based routing** to direct incoming traffic to the appropriate frontend service based on the URL path. Also allows to use ClusterIP service for all the services. The customer facing services are routed to using the ingress - no need for nodeport for the services.

* **Secure Communication with Network Policies**: Both **ingress** and **egress** Network Policies are implemented to enforce a zero-trust network model. This strictly controls which pods can communicate with each other and which pods are allowed to connect to external resources, enhancing the security posture of the application.

---

## Workload & Resource Management

* **StatefulSets for Stateful Workloads**: For applications that require stable network identifiers and persistent storage (like databases), **StatefulSets** are used instead of Deployments.

* **Persistent Storage**: Persistent Volumes (PV) and Persistent Volume Claims (PVC) are used to provide stable storage for StatefulSets, ensuring that data survives pod restarts and rescheduling.

* **Horizontal Pod Autoscaler (HPA)**: HPAs are configured for stateless deployments to automatically scale the number of pods up or down based on CPU or memory utilization. This ensures high availability and efficient resource usage.

* **Resource Limits**: Every pod has explicit **resource requests and limits** (CPU and memory) defined. This prevents any single container from consuming excessive resources and starving other applications, leading to better cluster stability.