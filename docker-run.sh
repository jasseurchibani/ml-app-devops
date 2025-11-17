#!/usr/bin/env bash
# Docker build and run script for ML App

set -e

echo "=== ML App Docker Build & Run Script ==="
echo ""

# Function to check if Docker is running
check_docker() {
    if ! docker ps > /dev/null 2>&1; then
        echo "❌ Docker is not running!"
        echo "Please start Docker Desktop and try again."
        exit 1
    fi
    echo "✓ Docker is running"
}

# Function to build image
build_image() {
    echo ""
    echo "Building Docker image..."
    docker build -t ml-app:latest .
    echo "✓ Image built successfully"
}

# Function to run training
run_training() {
    echo ""
    echo "Running training in Docker container..."
    docker run --rm --name ml-app-train \
        -v "$(pwd)/models:/app/models" \
        ml-app:latest
    echo "✓ Training completed"
}

# Function to run predictions
run_predictions() {
    echo ""
    echo "Running predictions in Docker container..."
    docker run --rm --name ml-app-predict \
        -v "$(pwd)/models:/app/models" \
        ml-app:latest python src/predict.py
    echo "✓ Predictions completed"
}

# Function to run tests
run_tests() {
    echo ""
    echo "Running tests in Docker container..."
    docker run --rm --name ml-app-test \
        ml-app:latest pytest tests/ -v
    echo "✓ Tests completed"
}

# Main menu
main() {
    check_docker
    
    echo ""
    echo "What would you like to do?"
    echo "1) Build image"
    echo "2) Build and run training"
    echo "3) Run predictions (requires trained model)"
    echo "4) Run tests"
    echo "5) Full workflow (build, train, predict, test)"
    echo "6) Exit"
    echo ""
    read -p "Enter your choice [1-6]: " choice
    
    case $choice in
        1)
            build_image
            ;;
        2)
            build_image
            run_training
            ;;
        3)
            run_predictions
            ;;
        4)
            run_tests
            ;;
        5)
            build_image
            run_training
            run_predictions
            run_tests
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please run the script again."
            exit 1
            ;;
    esac
    
    echo ""
    echo "=== Completed Successfully! ==="
}

# Run main function
main
