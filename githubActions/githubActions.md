# GitHub Actions: Concepts & Pipelines

A summary of GitHub Actions, covering core concepts, CI/CD pipelines, security, and runners.

---

## GitHub Actions: Core Concepts

**GitHub Actions** is a CI/CD platform that lets you automate software workflows directly in your GitHub repository. These workflows are event-driven, meaning they run in response to activities like a `push` to a branch or the creation of a `pull_request`.

* **Workflow**: An automated process defined in a YAML file, made up of one or more jobs.
* **Event**: A specific activity that triggers a workflow run.
* **Job**: A set of steps that execute on the same runner. Jobs run in parallel by default but can be configured to run sequentially.
* **Step**: An individual task that can run commands or use a pre-built Action.
* **Action**: A reusable unit of code that performs a complex task, like `actions/checkout`.
* **Runner**: A server that runs your workflows. You can use runners hosted by GitHub or self-hosted runners.

---

## Building a CI/CD Pipeline

A typical CI/CD pipeline automates the process of testing, building, and deploying your application.

### Workflow Structure & Triggers
Workflows are defined in YAML files located in the `.github/workflows/` directory.

* **`name`**: The name of the workflow displayed on GitHub.
* **`on`**: The event that triggers the workflow, such as `push`, `pull_request`, `schedule`, or `workflow_dispatch` for manual runs.
* **`jobs`**: Contains all the jobs that make up the workflow.

### Example Multi-Job Pipeline
This example shows a common pipeline structure with jobs for testing, building a Docker image, and deploying.

1.  **Job 1: Test the Application**
    This job checks out the code, sets up the environment, installs dependencies, and runs tests.
    ```yaml
    test:
      name: Unit Tests
      runs-on: ubuntu-latest
      steps:
        - name: Checkout code
          uses: actions/checkout@v4
        - name: Setup Node.js
          uses: actions/setup-node@v4
          with:
            node-version: '18'
            cache: 'npm'
        - name: Install dependencies
          run: npm ci
        - name: Run tests
          run: npm test
    ```

2.  **Job 2: Build and Push Docker Image**
    This job builds a Docker image and pushes it to a container registry. It uses secrets for authentication.
    ```yaml
    build:
      name: Build & Push Docker Image
      runs-on: ubuntu-latest
      needs: test # **This job waits for the 'test' job to succeed**
      steps:
        - name: Checkout code
          uses: actions/checkout@v4
        - name: Log in to a container registry
          uses: docker/login-action@v3
          with:
            username: ${{ github.actor }}
            password: ${{ secrets.GITHUB_TOKEN }} # **A secret for authentication**
        - name: Build and push Docker image
          uses: docker/build-push-action@v5
          with:
            context: .
            push: true
            tags: my-image:latest
    ```
3.  **Job 3: Deploy to an Environment**
    This conceptual job shows a deployment that runs only on a push to `main` and uses environment protection rules.
    ```yaml
    deploy-staging:
      name: Deploy to Staging
      runs-on: ubuntu-latest
      needs: build
      environment: # **Defines the deployment environment**
        name: staging
        url: [https://staging.example.com](https://staging.example.com)
      steps:
        - name: Deploy to staging environment
          run: echo "Deploying to staging..."
          env:
            API_KEY: ${{ secrets.STAGING_API_KEY }} # **Uses environment-specific secrets**
    ```

---

## DevSecOps: Integrating Security
DevSecOps involves integrating automated security checks directly into your CI pipeline.

* **Static Application Security Testing (SAST)**: Scans your source code for potential security flaws. Tools like GitHub's own **CodeQL** can be used for this.
* **Software Composition Analysis (SCA)**: Checks your application's dependencies for known vulnerabilities. This can be done with `npm audit` or tools like **Snyk**.
* **Container Security Scanning**: Scans your built Docker images for vulnerabilities. The **Trivy** action is a popular tool for this.

---

## Advanced: Self-Hosted Runners on Kubernetes
For more control and custom environments, you can deploy your own runners on a Kubernetes cluster.

* **What they are**: Self-hosted runners are machines that you provision and manage to execute GitHub Actions jobs.
* **Why use them on Kubernetes**: It provides excellent scalability, resource management, and integration with your cloud-native infrastructure.
* **Actions Runner Controller (ARC)**: This is the official Kubernetes operator from GitHub for managing self-hosted runners. It automates the creation, scaling, and lifecycle of runner pods within your cluster and is typically installed via a **Helm chart**.