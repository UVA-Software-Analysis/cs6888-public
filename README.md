# Getting Started

The first thing to do is to clone this repository. Follow the instructions within the Canvas.

## Option 1: Use Pre-built Docker Image (Recommended)

You can use the pre-built Docker image from GitHub Container Registry (ghcr.io), which saves you from building locally (5-30 minutes).

```bash
docker-compose pull
docker-compose up -d main
docker-compose exec main bash
```

This will pull the image and start the container.

To stop the container:

```bash
docker-compose stop
```

## Option 2: Build Docker Image Locally

If you prefer to build the image yourself or need to make modifications, edit `docker-compose.yml`:
- Comment out the `image:` line
- Uncomment the `build: .` line

Then run:

```bash
docker-compose up --build main -d
```

Building may take 5-30 minutes depending on your hardware.

Once built successfully, execute the following command from another terminal in the same working directory:

```bash
docker-compose exec main bash
```

---

The final command will drop you into a shell where you can execute commands and scripts that we have provided.
