# Advanced Docker Concepts

A summary of Dockerfiles, multi-stage builds, volumes, networking, and Docker Compose.

---

## Writing Efficient Dockerfiles

A **Dockerfile** is a text file with step-by-step instructions that Docker follows to build a container image[cite: 4, 5].

* **Essential Instructions**:
    * `FROM`: Specifies the base image to build upon (e.g., `python:3.11-slim`)[cite: 6].
    * `WORKDIR`: Sets the working directory inside the container for subsequent commands[cite: 6].
    * `COPY`: Copies files from your computer into the container[cite: 6, 7].
    * `RUN`: Executes commands during the image build process, such as installing packages[cite: 7].
    * `EXPOSE`: Informs Docker which network port the container listens on at runtime[cite: 8].
    * `CMD`: Provides the default command to run when the container starts[cite: 8, 9].
* **Best Practices for Efficiency**:
    * **Choose Small Base Images**: Use `slim` or `alpine` tags (e.g., `node:18-alpine`) to reduce the final image size[cite: 9].
    * **Use a `.dockerignore` file**: Exclude unnecessary files like `node_modules`, `.git`, and log files from being copied into the image[cite: 11].
    * **Optimize Layer Caching**: Place instructions that change less often, like dependency installation, before instructions that change frequently, like copying source code[cite: 11, 12].
    * **Clean Up**: Remove package manager caches and temporary files in the same `RUN` layer to keep the image lean[cite: 10].

---

## Multi-Stage Builds

A multi-stage build uses multiple `FROM` statements in a single Dockerfile to separate the build environment from the final runtime environment[cite: 13]. This is a powerful technique to create smaller, more secure production images[cite: 14].

* **How it works**:
    1.  A "build" stage is created using an image that contains all the necessary compilers and build tools (e.g., `FROM golang:1.21-alpine AS builder`)[cite: 15, 17].
    2.  A final "runtime" stage is created using a minimal base image (e.g., `FROM alpine:latest`)[cite: 16, 17].
    3.  Only the necessary artifacts (like compiled binaries or static assets) are copied from the build stage into the final runtime stage[cite: 16, 17].

---

## Managing Data in Containers

By default, data created inside a container is **ephemeral**, meaning it's lost when the container is removed[cite: 150]. Docker provides two ways to persist data[cite: 151].

* **Bind Mounts**: This directly connects a folder on your computer (the host) to a folder inside the container[cite: 151, 152]. This is very useful for development, as changes made to files on the host are immediately reflected in the container[cite: 152].
* **Volumes**: These are storage spaces fully managed by Docker[cite: 153]. They are the preferred method for persisting data for applications like databases, as the data exists independently of the container's lifecycle[cite: 153].
* **Volume Commands**:
    * `docker volume create <volume_name>`: Creates a new volume[cite: 154].
    * `docker volume ls`: Lists all available volumes[cite: 154].
    * `docker volume rm <volume_name>`: Removes a volume[cite: 154].
    * `docker volume prune`: Removes all unused volumes[cite: 154].

---

## Docker Networking

Networking allows containers to communicate with each other and with the outside world[cite: 158, 159].

* **Bridge Network**: This is the default network type, creating a private internal network for containers[cite: 159]. For better security and service discovery by name, it's recommended to create a **custom bridge network**[cite: 160].
* **Host Network**: The container shares the host machine's network directly, offering better performance but reduced security[cite: 161, 162].
* **Network Commands**:
    * `docker network create <network_name>`: Creates a new custom network[cite: 163].
    * `docker network ls`: Lists all available networks[cite: 163].
    * `docker network inspect <network_name>`: Provides detailed information about a network[cite: 164].

---

## Docker Compose

**Docker Compose** is a tool for defining and running multi-container Docker applications[cite: 165]. It uses a simple YAML file (`docker-compose.yml`) to configure all the application's services, networks, and volumes[cite: 165, 166].

* **Benefits**:
    * Simplifies management of multiple containers with a single configuration file[cite: 166, 167].
    * Creates a consistent, reproducible environment for all team members[cite: 167].
    * Automatically creates a network for all services defined in the file, allowing them to communicate easily.
* **Common Commands**:
    * `docker-compose up`: Builds, creates, and starts all services defined in the file[cite: 169]. Use the `-d` flag to run in the background[cite: 169].
    * `docker-compose down`: Stops and removes all containers and networks created by `up`[cite: 169].
    * `docker-compose logs <service_name>`: Views the logs from a specific service[cite: 169].