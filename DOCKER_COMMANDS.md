# Docker Quick Reference

## Prerequisites
```bash
# Check Docker is running
docker --version
docker ps
```

## Build Image
```bash
docker build -t ml-app:latest .
```

## Run Training
```bash
# Basic (model stays in container)
docker run --rm ml-app:latest

# With volume mount (model persists on host)
docker run --rm -v ${PWD}/models:/app/models ml-app:latest
```

## Run Predictions
```bash
docker run --rm -v ${PWD}/models:/app/models ml-app:latest python src/predict.py
```

## Run Tests
```bash
docker run --rm ml-app:latest pytest tests/ -v
```

## Interactive Shell
```bash
docker run -it --rm ml-app:latest /bin/bash
```

## Using Docker Compose
```bash
# Train
docker-compose up ml-app-train

# Predict
docker-compose up ml-app-predict

# Test
docker-compose up ml-app-test

# Clean up
docker-compose down
```

## Helper Scripts

### Windows (PowerShell)
```powershell
.\docker-run.ps1
```

### Linux/Mac (Bash)
```bash
chmod +x docker-run.sh
./docker-run.sh
```

## Troubleshooting

### Docker not running
Start Docker Desktop

### Port in use
```bash
docker ps
docker stop <container-name>
```

### Clean up
```bash
docker system prune -a
```
