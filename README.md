# Welcome to this PoC!

Below is the step-by-step guide to spin up the Proof of Concept.

## 1. Prerequisites

Ensure you have the following installed and configured:
- **Container Runtime:** Docker, Podman, etc.
- **Container Runtime Compose:** Docker Compose, Podman Compose, etc.
- **Git:** Version control system.
- **OS:** Unix-based OS (MacOS or Debian-based Linux distros).

---

## 2. Installation & Configuration

### 2.1. Installing a Docker Runtime
Visit the [Docker Engine Installation Guide](https://docs.docker.com/engine/install/) and select your operating system to install Docker.

### 2.2. Permissions
To allow interactions with the Docker API, you must change the ownership of `docker.sock`. This allows applications to scale containers in and out.

**For Docker (Debian-based Linux):**
```bash
sudo chown -R <user_group>:docker /var/run/docker.sock
```

**For Podman:**
```bash
sudo chown -R <user_group>:docker /var/run/podman/podman.sock
```

### 2.3. Install Git
To install Git, visit the [official installation page](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and follow the steps for your operating system.

---

## 3. Repository Setup

### 3.1. Clone and Navigate
Run the following commands to clone the repo and navigate to the correct folder:

```bash
git clone [https://github.com/jhonnyJET/ws-horizontal-scaling.git](https://github.com/jhonnyJET/ws-horizontal-scaling.git)
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

**Podman:**
```bash
podman compose -d
```

---

## 5. Happy Testing!!

Follow alongside the video or feel free to make your own tests:
[Video link]