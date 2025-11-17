# Use official Python runtime as base image
FROM python:3.9-slim

# Set metadata
LABEL maintainer="ML App DevOps"
LABEL description="Iris Classifier ML Application"
LABEL version="1.0"

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Set the working directory inside the container
WORKDIR /app

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy application code
COPY src/ ./src/
COPY tests/ ./tests/
COPY .flake8 pytest.ini ./

# Create necessary directories
RUN mkdir -p models logs

# Expose port for future API (when Flask/FastAPI is added)
EXPOSE 8000

# Add healthcheck (placeholder for when API is added)
# HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
#   CMD python -c "import requests; requests.get('http://localhost:8000/health')" || exit 1

# Default command: Run training
CMD ["python", "src/train.py"]

# Alternative commands (can be overridden):
# docker run ml-app python src/predict.py
# docker run ml-app pytest tests/
