# Docker Containerization Guide

## Prerequisites

### Start Docker Desktop
1. Open Docker Desktop application
2. Wait for Docker to start (whale icon in system tray should be steady)
3. Verify Docker is running:
   ```bash
   docker --version
   docker ps
   ```

## Building the Docker Image

### 1. Build the Image
```bash
# From the project root directory
docker build -t ml-app:latest .
```

**Expected output:**
- Downloads Python 3.9 slim base image
- Installs dependencies from requirements.txt
- Copies application code
- Creates necessary directories
- Tags image as `ml-app:latest`

### 2. Verify Image was Built
```bash
docker images ml-app
```

**Expected output:**
```
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
ml-app       latest    xxxxxxxxxxxx   X seconds ago    XXX MB
```

## Running the Docker Container

### Option 1: Run Training (Default)
```bash
docker run --rm --name ml-app-train ml-app:latest
```

**What it does:**
- Runs the training script (`src/train.py`)
- Trains the Iris classifier model
- Displays training results
- Container is removed after completion (`--rm`)

**Expected output:**
```
Starting Iris Classifier Training...
Loading Iris dataset...
Training set size: 120
Test set size: 30
Training Logistic Regression model...
Evaluating model...
Model Accuracy: 0.XXXX
Classification Report:
...
Training completed successfully!
```

### Option 2: Run with Model Persistence
```bash
# Create models directory if it doesn't exist
mkdir -p models

# Run with volume mount to save model
docker run --rm --name ml-app-train \
  -v ${PWD}/models:/app/models \
  ml-app:latest
```

**Windows PowerShell:**
```powershell
docker run --rm --name ml-app-train -v ${PWD}/models:/app/models ml-app:latest
```

### Option 3: Run Predictions
```bash
# After training, run predictions
docker run --rm --name ml-app-predict \
  -v ${PWD}/models:/app/models \
  ml-app:latest python src/predict.py
```

### Option 4: Run Tests
```bash
docker run --rm --name ml-app-test \
  ml-app:latest pytest tests/ -v
```

### Option 5: Interactive Shell
```bash
# Open bash shell inside container
docker run -it --rm ml-app:latest /bin/bash

# Then run commands manually
python src/train.py
python src/predict.py
pytest tests/
```

## Using Docker Compose

Docker Compose provides an easier way to manage multiple containers.

### 1. Train the Model
```bash
docker-compose up ml-app-train
```

### 2. Run Predictions
```bash
docker-compose up ml-app-predict
```

### 3. Run Tests
```bash
docker-compose up ml-app-test
```

### 4. Run All Services
```bash
docker-compose up
```

### 5. Stop and Remove Containers
```bash
docker-compose down
```

## Docker Image Details

### Image Specifications
- **Base Image:** python:3.9-slim
- **Working Directory:** /app
- **Exposed Port:** 8000 (for future API)
- **Default Command:** python src/train.py

### Environment Variables
- `PYTHONUNBUFFERED=1` - Ensures Python output is sent straight to terminal
- `PYTHONDONTWRITEBYTECODE=1` - Prevents Python from writing .pyc files
- `PIP_NO_CACHE_DIR=1` - Reduces image size
- `PIP_DISABLE_PIP_VERSION_CHECK=1` - Speeds up pip operations

### Volumes
- `/app/models` - For model persistence
- `/app/logs` - For application logs

### Network
- **Port 8000** - Reserved for future REST API

## Advanced Docker Commands

### View Container Logs
```bash
docker logs ml-app-train
```

### View Running Containers
```bash
docker ps
```

### View All Containers (including stopped)
```bash
docker ps -a
```

### Stop a Running Container
```bash
docker stop ml-app-train
```

### Remove a Container
```bash
docker rm ml-app-train
```

### Remove the Image
```bash
docker rmi ml-app:latest
```

### Inspect the Image
```bash
docker inspect ml-app:latest
```

### View Image Layers and Size
```bash
docker history ml-app:latest
```

## Troubleshooting

### Issue: "Cannot connect to Docker daemon"
**Solution:** Start Docker Desktop application

### Issue: "Port already in use"
**Solution:** 
```bash
# Find process using the port
docker ps
# Stop the container
docker stop <container-name>
```

### Issue: "No space left on device"
**Solution:**
```bash
# Remove unused images and containers
docker system prune -a
```

### Issue: Model not persisting
**Solution:** Use volume mounts
```bash
docker run --rm -v ${PWD}/models:/app/models ml-app:latest
```

### Issue: Dependencies not found
**Solution:** Rebuild the image
```bash
docker build --no-cache -t ml-app:latest .
```

## Performance Optimization

### Multi-stage Build (Future Enhancement)
```dockerfile
# Build stage
FROM python:3.9-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Runtime stage
FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
CMD ["python", "src/train.py"]
```

### Reduce Image Size
- Use Alpine Linux base image
- Remove unnecessary dependencies
- Use .dockerignore effectively

## CI/CD Integration

The Docker image is automatically built in GitHub Actions:
- See `.github/workflows/ci.yml`
- Image is saved as artifact after each successful build
- Can be deployed to container registries (Docker Hub, AWS ECR, etc.)

## Next Steps

1. **Add REST API:**
   - Use Flask or FastAPI
   - Expose prediction endpoint on port 8000
   - Update Dockerfile CMD

2. **Push to Registry:**
   ```bash
   docker tag ml-app:latest username/ml-app:latest
   docker push username/ml-app:latest
   ```

3. **Deploy to Cloud:**
   - AWS ECS/EKS
   - Azure Container Instances
   - Google Cloud Run
   - Kubernetes cluster

## Example: Complete Workflow

```bash
# 1. Build the image
docker build -t ml-app:latest .

# 2. Train the model and save it
docker run --rm -v ${PWD}/models:/app/models ml-app:latest

# 3. Run predictions using the saved model
docker run --rm -v ${PWD}/models:/app/models ml-app:latest python src/predict.py

# 4. Run tests
docker run --rm ml-app:latest pytest tests/ -v

# 5. Clean up
docker rmi ml-app:latest
```

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Python Docker Images](https://hub.docker.com/_/python)
