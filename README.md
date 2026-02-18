# Welcome to this PoC!

This Proof concept consists of a container runtime environment demonstrating how to 
horizontal scale servers/containers based on the number of persistent connections.

Here is a breakdown of the containers we'll spin up and their role:

- socket-proxy: A security-enhanced proxy that runs as a container to control and restrict access to the host's primary Docker socket.
- consul: A distributed service networking platform providing service discovery, configuration, and security (service mesh).
- registrator: DNS discovery service for containers. Works with the container runtime socket to discover containers.
- haproxy: Open-source, high-performance load balancer and proxy server for TCP and HTTP-based applications.
- haproxy-sidecar: Based off a consul-template image will act as sidecar container to dynamically update haproxy configs to list consul discovered services.
- ws-app: Our persistent connection application server, developed with java quarkus. [Source code](https://github.com/jhonnyJET/ws-app)
- ws-balancer-app: Our persistent connection balancer application. This application reads the current state of consul services as well as the connection topology from the redis backplane to make decisions for scaling and rebalancing. [Source Code](https://github.com/jhonnyJET/connection-rebalancer)
- ws-frontend-app: A very simple react app which the only purpose is to show a visual representation of the persistent connection topology. [Source Code](https://github.com/jhonnyJET/communications_app)
- ws-client-app: This is an application to simulate websocket clients for the purpose of experimenting with this PoC. This websocket client has retry mechanisms, jitter, multi=threading for batch connecting users. [Source code](https://github.com/jhonnyJET/ws-client-app)
- redis: An in-memory data structure store. In the context of this PoC we use it to persist connection metadata and also as a Pub/Sub mechanism for our multiple instances to use as a backplane.

Below is the step-by-step guide to spin up the Proof of Concept.

## 1. Prerequisites

Ensure you have the following installed and configured:
- **Container Runtime:** Docker, Podman, etc.
- **Container Runtime Compose:** Docker Compose, Podman Compose, etc.
- **Git:** Version control system.
- **OS:** MacOS or Debian-based Linux.

---

## 2. Installation & Configuration

### 2.1. Installing a Docker Runtime
Visit the [Docker Engine Installation Guide](https://docs.docker.com/engine/install/) and select your operating system to install Docker.

### 2.2. Permissions
To allow interactions with the Docker API, you must change the ownership of `docker.sock`. (This allows applications containers to interact with docker API).

**For Docker (Debian-based Linux):**
```bash
sudo chown -R <user_group>:docker /var/run/docker.sock
```

### 2.3. Install Git
To install Git, visit the [official installation page](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and follow the steps for your operating system.

---

## 3. Repository Setup

### 3.1. Clone and Navigate
Run the following commands to clone the repo and navigate to the correct folder:

```bash
git clone https://github.com/jhonnyJET/ws-horizontal-scaling.git
cd ws-horizontal-scaling
cd docker
```

### 3.2. Configuration (.env)
Edit the `.env` file present in the `docker` folder. **Crucial:** Update the following information:

- **`OS_ARCH`**
  - Select your OS architecture (either `amd64` or `arm64`).
- **`DOCKER_SOCK`**
  - This depends on both your OS and Container runtime. Read the comments in the file to update with the correct value.
- **`CONNECTION_LIMIT_PER_HOST`**
  - The threshold of users each server/container will consider maximum.
- **`OVERUTILIZED_TOLERANCE_PERCENT`**
  - The tolerance for an overutilized server. (e.g., If a server is overutilized by over 10%, scaling out measures will be taken to bring more servers online).
- **`UNDERUTILIZED_TOLERANCE_PERCENT`**
  - The tolerance for an underutilized server. (e.g., If a server is underutilized by under 10%, scaling in measures will be taken to stop traffic to, and later remove, underutilized containers).
- **`MAX_UTILIZATION_PERCENT`**
  - The maximum percentage of connection utilization considered ideal per server/container.
- **`MIN_UTILIZATION_PERCENT`**
  - The minimum percentage of connection utilization considered ideal per server/container.
- **`MAX_CONNECTIONS_PER_HOST`**
  - The hard limit for the number of connections in each server. If more requests are sent to a server with 30 connections, the server will throw exceptions and refuse the connection.

---

## 4. Spin Up the Containers

In the same folder used in the previous step, run the compose command matching your runtime.

**Docker:**
```bash
docker compose up -d
```
---

## 5. Let's test!

Here are a few suggestions for tests:

1. Stress test the max number of connections per host (MAX_CONNECTIONS_PER_HOST). 
Using the curl templates in the template folder try batch connecting more users than the specified MAX_CONNECTIONS_PER_HOST. This will cause the servers to reject connections until fresh new servers are available and ready to receive new connection requests.

2. Happy path. Gradually batch connect more users, once overall utilization goes over (MAX_UTILIZATION_PERCENT + OVERUTILIZED_TOLERANCE_PERCENT), watch new servers/containers come online and receive 
new connection requests based on Least Connecion Load balancing.

3. Happy path. Gradually batch disconnect users from servers, once overall utilization dips below MIN_UTILIZATION_PERCENT, watch servers/containers being marked as 
unavailable, thus, the load balancer forwards traffic to the remaining active servers therefore raising overall utilization.

4. Swiss Cheese effect: Batch disconnect users from the same host, leaving the network topology with uneven load to force the rebalancer application to kick in and rebalance the connection topology.


