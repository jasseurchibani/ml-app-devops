# GitHub Actions CI Workflow Documentation

## Overview

This document describes the GitHub Actions CI/CD workflow implemented for the ML App DevOps project. The workflow automatically builds, tests, and validates code changes on every push and pull request.

## Workflow File

**Location:** `.github/workflows/ci.yml`

## Trigger Events

The workflow is triggered on:
- **Push** to `main` and `develop` branches
- **Pull Requests** targeting `main` and `develop` branches

## Jobs

### 1. Build and Test Job (`build-and-test`)

Runs on: `ubuntu-latest`

**Matrix Strategy:**
- Tests across multiple Python versions: 3.9, 3.10, 3.11
- Ensures compatibility with different Python versions

**Steps:**

#### Step 1: Checkout Code
```yaml
- uses: actions/checkout@v4
```
Checks out the repository code to the runner.

#### Step 2: Set Up Python
```yaml
- uses: actions/setup-python@v5
  with:
    python-version: ${{ matrix.python-version }}
    cache: 'pip'
```
- Sets up the specified Python version
- Caches pip dependencies for faster builds
- Official action: https://github.com/actions/setup-python

#### Step 3: Display Python Version
```bash
python --version
pip --version
```
Verifies Python and pip versions for debugging.

#### Step 4: Install Dependencies
```bash
python -m pip install --upgrade pip
pip install -r requirements.txt
```
Installs all project dependencies from `requirements.txt`.

#### Step 5: Lint with Flake8
```bash
flake8 src/ tests/ --count --show-source --statistics
```
- Checks code style compliance (PEP 8)
- Shows source code for each error
- Displays statistics
- Configuration: `.flake8`

#### Step 6: Check Code Formatting
```bash
black --check src/ tests/
```
Verifies code is formatted according to Black standards.

#### Step 7: Run Tests with Pytest
```bash
pytest tests/ -v --tb=short --junitxml=test-results.xml --cov=src --cov-report=xml --cov-report=html
```
- Runs all unit tests
- Generates JUnit XML report for test results
- Collects code coverage data
- Generates coverage reports (XML and HTML)
- Configuration: `pytest.ini`

#### Step 8: Upload Test Results
```yaml
- uses: actions/upload-artifact@v4
  with:
    name: test-results-python-${{ matrix.python-version }}
    path: test-results.xml
    retention-days: 30
```
- Uploads test results as artifacts
- Separate artifact for each Python version
- Retained for 30 days
- Can be downloaded from GitHub Actions UI

#### Step 9: Upload Coverage Reports
```yaml
- uses: actions/upload-artifact@v4
  with:
    name: coverage-report-python-${{ matrix.python-version }}
    path: |
      coverage.xml
      htmlcov/
    retention-days: 30
```
- Uploads code coverage reports
- Includes both XML and HTML formats
- Viewable in GitHub Actions

#### Step 10: Upload to Codecov (Optional)
```yaml
- uses: codecov/codecov-action@v4
  if: matrix.python-version == '3.9'
```
- Uploads coverage to Codecov (if configured)
- Only runs for Python 3.9 to avoid duplicates

### 2. Docker Build Job (`docker-build`)

Runs on: `ubuntu-latest`
Depends on: `build-and-test` (only runs if tests pass)

**Steps:**

#### Step 1: Checkout Code
```yaml
- uses: actions/checkout@v4
```

#### Step 2: Set Up Docker Buildx
```yaml
- uses: docker/setup-buildx-action@v3
```
Sets up Docker Buildx for advanced build features.

#### Step 3: Build Docker Image
```bash
docker build -t ml-app:${{ github.sha }} -t ml-app:latest .
```
- Builds Docker image from Dockerfile
- Tags with both commit SHA and 'latest'

#### Step 4: Test Docker Image
```bash
docker run --rm ml-app:latest python --version
```
Validates that the Docker image works correctly.

#### Step 5: Save Docker Image
```bash
docker save ml-app:latest -o ml-app-image.tar
gzip ml-app-image.tar
```
- Saves Docker image to tar archive
- Compresses with gzip for efficient storage

#### Step 6: Upload Docker Image Artifact
```yaml
- uses: actions/upload-artifact@v4
  with:
    name: docker-image
    path: ml-app-image.tar.gz
    retention-days: 7
    compression-level: 0
```
- Uploads Docker image as artifact
- Available for download from workflow run
- Retained for 7 days
- No additional compression (already gzipped)

#### Step 7: Display Image Info
```bash
docker images ml-app
docker inspect ml-app:latest
```
Shows Docker image details and size.

## Artifacts

### Test Results
- **Name:** `test-results-python-{version}`
- **Contents:** JUnit XML test results
- **Retention:** 30 days
- **Use:** View test execution details

### Coverage Reports
- **Name:** `coverage-report-python-{version}`
- **Contents:** XML and HTML coverage reports
- **Retention:** 30 days
- **Use:** Analyze code coverage

### Docker Image
- **Name:** `docker-image`
- **Contents:** Compressed Docker image (tar.gz)
- **Retention:** 7 days
- **Use:** Deploy or test the built image

## Viewing Workflow Results

### In GitHub UI:
1. Go to repository → **Actions** tab
2. Click on a workflow run
3. View job logs and test results
4. Download artifacts from the workflow run page

### Downloading Artifacts:
```bash
# Using GitHub CLI
gh run download <run-id> -n test-results-python-3.9

# Or download from GitHub UI
# Actions → Workflow Run → Artifacts section
```

## Configuration Files

### 1. `.flake8` - Linter Configuration
- Max line length: 88 (Black compatible)
- Ignored errors: E203, E266, W503, W504
- Max complexity: 10

### 2. `pytest.ini` - Test Configuration
- Test directory: `tests/`
- Coverage source: `src/`
- Output format: verbose with short traceback

### 3. `requirements.txt` - Dependencies
Includes testing dependencies:
- pytest
- pytest-cov
- black
- flake8

## Local Testing

To run the same checks locally:

```bash
# Activate virtual environment
.venv\Scripts\Activate.ps1  # Windows
source .venv/bin/activate   # Linux/Mac

# Install dependencies
pip install -r requirements.txt

# Run linter
flake8 src/ tests/

# Check formatting
black --check src/ tests/

# Run tests with coverage
pytest tests/ -v --cov=src --cov-report=html

# Build Docker image
docker build -t ml-app .
```

## Status Badges

Add to README.md:

```markdown
![CI Pipeline](https://github.com/jasseurchibani/ml-app-devops/workflows/CI%20Pipeline/badge.svg)
```

## Troubleshooting

### Tests Fail
- Check test logs in GitHub Actions UI
- Download test-results.xml artifact
- Run tests locally to reproduce

### Linting Errors
- Download workflow logs
- Run `flake8 src/ tests/` locally
- Fix issues and commit

### Docker Build Fails
- Check Dockerfile syntax
- Verify all dependencies are in requirements.txt
- Test Docker build locally

## Best Practices

1. **Always run tests locally** before pushing
2. **Keep dependencies updated** in requirements.txt
3. **Write meaningful commit messages** for better workflow tracking
4. **Review coverage reports** to maintain high test coverage
5. **Check workflow status** before merging pull requests

## References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [actions/setup-python](https://github.com/actions/setup-python)
- [actions/upload-artifact](https://github.com/actions/upload-artifact)
- [Docker Build Action](https://github.com/docker/build-push-action)
- [Pytest Documentation](https://docs.pytest.org/)
- [Coverage.py Documentation](https://coverage.readthedocs.io/)
