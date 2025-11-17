# ML App DevOps - Report

## Project Setup

### Environment Setup
1. **Created Virtual Environment:**
   ```bash
   python -m venv .venv
   ```

2. **Activated Virtual Environment:**
   ```powershell
   .venv\Scripts\Activate.ps1
   ```

3. **Installed Dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
   
   **Note:** The original requirements.txt specified versions incompatible with Python 3.12. Updated to compatible versions:
   - scikit-learn: 1.7.2
   - pandas: 2.3.3
   - numpy: 2.3.5
   - matplotlib: 3.10.7
   - seaborn: 0.13.2
   - pytest: 9.0.1
   - black: 25.11.0
   - flake8: 7.3.0

## Running the Application

### 1. Train the Model
```bash
python src/train.py
```

**What it does:**
- Loads the Iris dataset
- Splits data into training and test sets (80/20)
- Trains a Logistic Regression model
- Evaluates model performance
- Saves the trained model to `models/iris_classifier.pkl`
- Generates visualization plots:
  - `confusion_matrix.png` - Shows prediction accuracy across classes
  - `feature_importance.png` - Shows feature coefficients

**Expected Output:**
- Model accuracy score
- Classification report (precision, recall, F1-score)
- Saved model file
- Generated plots

### 2. Make Predictions
```bash
python src/predict.py
```

**What it does:**
- Loads the trained model from `models/iris_classifier.pkl`
- Runs example predictions on three sample flower measurements
- Displays predicted class and probability distribution

**Example Predictions:**
- Input: `[5.1, 3.5, 1.4, 0.2]` → Expected: Setosa
- Input: `[6.7, 3.0, 5.2, 2.3]` → Expected: Virginica
- Input: `[5.9, 3.0, 4.2, 1.5]` → Expected: Versicolor

## Testing the Application

### Run Unit Tests
```bash
pytest tests/test_model.py -v
```

**What it tests:**
- Model initialization
- Training functionality
- Prediction accuracy
- Model save/load operations

### Code Quality Checks

**Lint code with Flake8:**
```bash
flake8 src/ tests/
```

**Expected output:** `0` (no errors) ✅

**Format code with Black:**
```bash
black src/ tests/
```

**Flake8 Configuration:**
- Configuration file: `.flake8`
- Max line length: 88 characters (Black compatible)
- Ignores: E203, E266, W503, W504
- Max complexity: 10
- See `LINTING.md` for detailed documentation

## CI/CD Pipeline

### GitHub Actions Workflow
Automated CI pipeline runs on every push and pull request:

**Workflow:** `.github/workflows/ci.yml`

**What it does:**
1. ✅ Checks out code
2. ✅ Sets up Python (3.9, 3.10, 3.11)
3. ✅ Installs dependencies
4. ✅ Runs flake8 linter
5. ✅ Checks Black formatting
6. ✅ Runs pytest with coverage
7. ✅ Uploads test results and coverage reports as artifacts
8. ✅ Builds Docker image
9. ✅ Uploads Docker image as artifact

**View workflow runs:**
- GitHub Actions tab in repository
- See `CI_WORKFLOW.md` for detailed documentation

**Artifacts available after each run:**
- Test results (JUnit XML)
- Coverage reports (XML + HTML)
- Docker image (tar.gz)

## Docker Containerization

### Docker Setup

**Files:**
- `Dockerfile` - Container image definition
- `docker-compose.yml` - Multi-container orchestration
- `.dockerignore` - Excludes unnecessary files from image
- `docker-run.ps1` - PowerShell helper script (Windows)
- `docker-run.sh` - Bash helper script (Linux/Mac)

### Quick Start

**1. Build the Docker image:**
```bash
docker build -t ml-app:latest .
```

**2. Run training in container:**
```bash
# Basic (model stays in container)
docker run --rm ml-app:latest

# With volume mount (model persists on host)
docker run --rm -v ${PWD}/models:/app/models ml-app:latest
```

**3. Run predictions:**
```bash
docker run --rm -v ${PWD}/models:/app/models ml-app:latest python src/predict.py
```

**4. Run tests:**
```bash
docker run --rm ml-app:latest pytest tests/ -v
```

### Using Docker Compose

```bash
# Train the model
docker-compose up ml-app-train

# Run predictions
docker-compose up ml-app-predict

# Run tests
docker-compose up ml-app-test
```

### Helper Scripts

**Windows PowerShell:**
```powershell
.\docker-run.ps1
```

**Linux/Mac:**
```bash
chmod +x docker-run.sh
./docker-run.sh
```

### Docker Image Specifications

- **Base Image:** python:3.9-slim
- **Working Directory:** /app
- **Exposed Port:** 8000 (reserved for future API)
- **Volumes:** 
  - `/app/models` - Model persistence
  - `/app/logs` - Application logs
- **Default Command:** `python src/train.py`

**See `DOCKER_GUIDE.md` for comprehensive documentation**

## Project Structure
```
ml-app/
├── src/
│   ├── data_loader.py      # Load and preprocess Iris dataset
│   ├── model.py            # IrisClassifier class definition
│   ├── train.py            # Training script
│   ├── predict.py          # Prediction script
│   └── utils.py            # Visualization utilities
├── tests/
│   └── test_model.py       # Unit tests
├── models/                 # Saved model directory
├── requirements.txt        # Python dependencies
├── Dockerfile             # Docker configuration
└── README.md              # Project documentation
```

## API Endpoints

**Note:** This application currently runs as a command-line tool and does not have REST API endpoints. To add API functionality, consider:

1. **Adding Flask/FastAPI endpoints** for:
   - `POST /predict` - Accept flower measurements, return prediction
   - `GET /health` - Health check endpoint
   - `GET /model/info` - Model metadata and performance metrics

2. **Example Flask implementation:**
   ```python
   from flask import Flask, request, jsonify
   
   app = Flask(__name__)
   classifier = IrisClassifier()
   classifier.load_model('models/iris_classifier.pkl')
   
   @app.route('/predict', methods=['POST'])
   def predict():
       data = request.json
       features = data['features']  # [sepal_length, sepal_width, petal_length, petal_width]
       prediction = classifier.predict([features])[0]
       return jsonify({'prediction': int(prediction)})
   ```

## Repository

GitHub Repository: https://github.com/jasseurchibani/ml-app-devops

## Conclusion

The ML app successfully demonstrates:
- ✅ Machine learning model training and evaluation
- ✅ Model persistence and loading
- ✅ Command-line prediction interface
- ✅ Unit testing
- ✅ Code quality tools (Black, Flake8)
- ✅ Docker containerization support
- ✅ Version control with Git/GitHub

**Future enhancements:**
- Add REST API with Flask/FastAPI
- Implement CI/CD pipeline with GitHub Actions
- Add model versioning
- Deploy to cloud platform (AWS, Azure, GCP)
