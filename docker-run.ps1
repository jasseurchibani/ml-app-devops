# Docker build and run script for ML App (PowerShell)

Write-Host "=== ML App Docker Build & Run Script ===" -ForegroundColor Cyan
Write-Host ""

# Function to check if Docker is running
function Test-Docker {
    try {
        docker ps | Out-Null
        Write-Host "✓ Docker is running" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Docker is not running!" -ForegroundColor Red
        Write-Host "Please start Docker Desktop and try again." -ForegroundColor Yellow
        return $false
    }
}

# Function to build image
function Build-Image {
    Write-Host ""
    Write-Host "Building Docker image..." -ForegroundColor Yellow
    docker build -t ml-app:latest .
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Image built successfully" -ForegroundColor Green
        return $true
    }
    else {
        Write-Host "❌ Build failed" -ForegroundColor Red
        return $false
    }
}

# Function to run training
function Start-Training {
    Write-Host ""
    Write-Host "Running training in Docker container..." -ForegroundColor Yellow
    docker run --rm --name ml-app-train -v "${PWD}/models:/app/models" ml-app:latest
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Training completed" -ForegroundColor Green
        return $true
    }
    else {
        Write-Host "❌ Training failed" -ForegroundColor Red
        return $false
    }
}

# Function to run predictions
function Start-Predictions {
    Write-Host ""
    Write-Host "Running predictions in Docker container..." -ForegroundColor Yellow
    docker run --rm --name ml-app-predict -v "${PWD}/models:/app/models" ml-app:latest python src/predict.py
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Predictions completed" -ForegroundColor Green
        return $true
    }
    else {
        Write-Host "❌ Predictions failed" -ForegroundColor Red
        return $false
    }
}

# Function to run tests
function Start-Tests {
    Write-Host ""
    Write-Host "Running tests in Docker container..." -ForegroundColor Yellow
    docker run --rm --name ml-app-test ml-app:latest pytest tests/ -v
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Tests completed" -ForegroundColor Green
        return $true
    }
    else {
        Write-Host "❌ Tests failed" -ForegroundColor Red
        return $false
    }
}

# Main menu
function Show-Menu {
    Write-Host ""
    Write-Host "What would you like to do?" -ForegroundColor Cyan
    Write-Host "1) Build image"
    Write-Host "2) Build and run training"
    Write-Host "3) Run predictions (requires trained model)"
    Write-Host "4) Run tests"
    Write-Host "5) Full workflow (build, train, predict, test)"
    Write-Host "6) Exit"
    Write-Host ""
}

# Main function
function Main {
    if (-not (Test-Docker)) {
        exit 1
    }
    
    Show-Menu
    $choice = Read-Host "Enter your choice [1-6]"
    
    switch ($choice) {
        "1" {
            Build-Image
        }
        "2" {
            if (Build-Image) {
                Start-Training
            }
        }
        "3" {
            Start-Predictions
        }
        "4" {
            Start-Tests
        }
        "5" {
            if (Build-Image) {
                if (Start-Training) {
                    Start-Predictions
                    Start-Tests
                }
            }
        }
        "6" {
            Write-Host "Exiting..." -ForegroundColor Yellow
            exit 0
        }
        default {
            Write-Host "Invalid choice. Please run the script again." -ForegroundColor Red
            exit 1
        }
    }
    
    Write-Host ""
    Write-Host "=== Completed Successfully! ===" -ForegroundColor Green
}

# Run main function
Main
