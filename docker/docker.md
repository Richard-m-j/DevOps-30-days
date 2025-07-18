# Docker Notes

A summary of core concepts and essential commands for Docker.

---

## Core Docker Concepts

* **Docker Architecture**: The system consists of three main parts: the **Docker Engine** (the background service that manages everything), the **Docker Client** (the command-line tool you use), and a **Docker Registry** (a storage service for images, like Docker Hub).
* **Image**: An image is a read-only template that contains the application code, libraries, and tools needed to run an application. Think of it as a recipe or a blueprint.
* **Container**: A container is a live, running instance created from an image. It's the actual application working and doing its job. Multiple containers can be run from the same image.

---

## Working with Images

* **`docker pull <image_name>`**: Downloads an image from a registry like Docker Hub to your computer.
* **`docker images`** or **`docker image ls`**: Shows all the images stored on your computer.
* **`docker build -t <my-app>`**: Creates a new image from a Dockerfile in the current directory.
* **`docker rmi <image_name>`**: Deletes an image from your computer.

---

## Working with Containers

* **`docker run <image_name>`**: Creates and starts a container from an image.
    * Use **`-d`** to run the container in the background (detached mode).
    * Use **`-p <host_port>:<container_port>`** to map a port from your computer to the container.
    * Use **`--name <my-container>`** to give the container a specific name.
* **`docker ps`**: Lists all currently running containers.
    * Use the **`-a`** flag (`docker ps -a`) to show all containers, including those that are stopped.
* **`docker stop <container_name>`**: Stops a running container.
* **`docker start <container_name>`**: Starts a container that has been stopped.
* **`docker rm <container_name>`**: Removes a stopped container.
* **`docker exec -it <container_name> /bin/bash`**: Opens an interactive command-line shell inside a running container.
* **`docker logs <container_name>`**: Shows the logs or output from a container.
* **`docker system prune -a`**: A cleanup command that removes all unused containers, images, and networks.
