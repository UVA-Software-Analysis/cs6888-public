# Getting Started

The first thing to do is to clone this repository. Follow the instructions within the Canvas.

## Option 1: Use Pre-built Docker Image (Recommended)

You can use the pre-built Docker image from GitHub Container Registry (ghcr.io), which saves you from building locally.

### Pull and Run the Image

```bash
# Pull the latest image
docker pull ghcr.io/UVA-Software-Analysis/cs6888-public:latest

# Run the container interactively
docker run -it --rm -v $(pwd)/files:/root/files ghcr.io/UVA-Software-Analysis/cs6888-public:latest bash
```

### Using Docker Compose with Pre-built Image

You can also use docker-compose. First, update the `docker-compose.yml` to use the pre-built image:

```yaml
services:
  main:
    image: ghcr.io/UVA-Software-Analysis/cs6888-public:latest
    volumes:
      - ./files:/root/files
    stdin_open: true
    tty: true
```

Then run:

```bash
docker-compose up -d main
docker-compose exec main bash
```

## Option 2: Build Docker Image Locally

If you prefer to build the image yourself or need to make modifications:

### Prerequisites

- Docker and Docker Compose installed on your machine
- Docker daemon running

### Build and Run

```bash
cd cs6888-public

# Build and start the container
docker-compose up --build main
```

Building may take from 5-30 minutes depending on your hardware, just be patient.

Once built successfully, execute the following command from another terminal in the same working directory:

```bash
docker-compose exec main bash
```

### Build Only (without Docker Compose)

```bash
# Build the image
docker build -t cs6888-public .

# Run the container
docker run -it --rm -v $(pwd)/files:/root/files cs6888-public bash
```

---

The final command will drop you into a shell where you can execute commands and scripts that we have provided.
