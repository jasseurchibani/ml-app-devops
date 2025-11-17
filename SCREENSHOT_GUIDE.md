# Screenshot Capture Guide - Step by Step

This guide will walk you through capturing all 23 required screenshots for your homework submission.

---

## Prerequisites

1. **Windows Snipping Tool**: Press `Win + Shift + S` to capture
2. **Save Location**: Create a folder `screenshots` in your project directory
3. **File Names**: Use descriptive names (e.g., `task4_flake8_config.png`)

---

## TASK 4: LINTING & FORMATTING (4 Screenshots)

### Screenshot 1: `.flake8` Configuration File

**What to capture**: The `.flake8` file content

**Steps**:
1. Open VS Code
2. Navigate to your project: `C:\Users\21655\Desktop\CI2\devops\DevOps-MLOps-Labs\session2\ml-app`
3. Click on `.flake8` file in the file explorer
4. Make sure the entire file content is visible in the editor
5. Press `Win + Shift + S` and select the area showing:
   - File name (`.flake8` in tab)
   - Full file content (all the configuration)
6. Save as: `task4_01_flake8_config.png`

**What should be visible**:
```
[flake8]
max-line-length = 88
exclude = ...
ignore = E203,E266,W503,W504
max-complexity = 10
...
```

---

### Screenshot 2: Flake8 Running with 0 Errors

**What to capture**: Terminal output showing flake8 passed with no errors

**Steps**:
1. Open PowerShell terminal in VS Code (Ctrl + `)
2. Make sure you're in the project directory
3. Run this command:
   ```powershell
   flake8 src/ tests/
   ```
4. Wait for it to complete (should return to prompt with no output)
5. Capture the terminal showing:
   - The command you typed
   - Empty output (meaning 0 errors)
   - The prompt returning
6. Save as: `task4_02_flake8_zero_errors.png`

**What should be visible**:
```powershell
(.venv) PS C:\...\ml-app> flake8 src/ tests/
(.venv) PS C:\...\ml-app> 
```
(Notice: no errors between the commands)

---

### Screenshot 3: Flake8 with Statistics

**What to capture**: Flake8 running with statistics flag

**Steps**:
1. In the same terminal, run:
   ```powershell
   flake8 src/ tests/ --statistics
   ```
2. Capture the terminal showing:
   - The command
   - Output showing "0" (no errors)
3. Save as: `task4_03_flake8_statistics.png`

**What should be visible**:
```powershell
(.venv) PS C:\...\ml-app> flake8 src/ tests/ --statistics
0
(.venv) PS C:\...\ml-app>
```

---

### Screenshot 4: Git Commit for Linting Changes

**What to capture**: Git log showing the linting commit

**Steps**:
1. In terminal, run:
   ```powershell
   git log --oneline -10
   ```
2. Capture the output showing the commit:
   - "Add flake8 linting configuration and fix all style issues"
3. Save as: `task4_04_git_commit.png`

**What should be visible**:
```
ac53486 Add flake8 linting configuration and fix all style issues
...
```

---

## TASK 5: GITHUB ACTIONS CI WORKFLOW (7 Screenshots)

### Screenshot 5: Workflow File in VS Code

**What to capture**: The `.github/workflows/ci.yml` file

**Steps**:
1. In VS Code, open file explorer
2. Navigate to: `.github/workflows/ci.yml`
3. Click on the file to open it
4. Scroll to the top of the file
5. Capture showing:
   - File name in tab
   - Beginning of the workflow (name, on, jobs)
6. You may need 2 screenshots to show the full file, or scroll to show key sections
7. Save as: `task5_01_workflow_file.png`

**What should be visible**:
```yaml
name: CI Pipeline

on:
  push:
    branches: [ main, develop ]
...
```

---

### Screenshot 6: Local Pytest Run

**What to capture**: Pytest running locally and passing all tests

**Steps**:
1. Make sure your virtual environment is activated
2. In terminal, run:
   ```powershell
   pytest tests/test_model.py -v
   ```
3. Wait for tests to complete
4. Capture the terminal showing:
   - The command
   - All 6 tests PASSED
   - Final summary (6 passed)
5. Save as: `task5_02_pytest_local.png`

**What should be visible**:
```powershell
====== test session starts ======
...
tests/test_model.py::TestIrisClassifier::test_model_initialization PASSED [ 16%]
tests/test_model.py::TestIrisClassifier::test_model_training PASSED [ 33%]
...
====== 6 passed in X.XXs ======
```

---

### Screenshot 7: GitHub Actions Tab

**What to capture**: GitHub repository showing Actions workflows

**Steps**:
1. Open your web browser
2. Go to: https://github.com/jasseurchibani/ml-app-devops
3. Click on the **"Actions"** tab
4. You should see workflow runs listed
5. Capture the page showing:
   - "Actions" tab selected
   - List of workflow runs
   - At least one "CI Pipeline" workflow
6. Save as: `task5_03_github_actions_tab.png`

**What should be visible**:
- Actions tab
- "CI Pipeline" workflows
- Green checkmarks (✓) for successful runs
- Workflow run names and dates

---

### Screenshot 8: Workflow Run Details

**What to capture**: Inside a workflow run showing all jobs completed

**Steps**:
1. On the GitHub Actions page, click on a successful workflow run
2. You should see the workflow details page
3. Make sure both jobs are visible:
   - "build-and-test" job
   - "docker-build" job
4. Both should show green checkmarks
5. Capture the page showing:
   - Workflow name at top
   - Both jobs completed successfully
   - Time taken
6. Save as: `task5_04_workflow_details.png`

**What should be visible**:
- Workflow run title
- ✓ build-and-test
- ✓ docker-build
- Both jobs green/successful

---

### Screenshot 9: Artifacts Section

**What to capture**: Artifacts uploaded by the workflow

**Steps**:
1. On the same workflow run page, scroll down
2. Look for the "Artifacts" section (usually at the bottom)
3. You should see artifacts like:
   - test-results-python-3.9
   - coverage-report-python-3.9
   - docker-image
4. Capture showing all artifacts
5. Save as: `task5_05_artifacts.png`

**What should be visible**:
- "Artifacts" heading
- List of artifacts with download icons
- File sizes
- Expiry dates

---

### Screenshot 10: setup-python in Workflow File

**What to capture**: The setup-python action in the YAML file

**Steps**:
1. Back in VS Code, open `.github/workflows/ci.yml`
2. Scroll to find the "Set up Python" step (around line 20-26)
3. Capture showing:
   - The step name
   - `uses: actions/setup-python@v5`
   - The `with:` section showing python-version and cache
4. Save as: `task5_06_setup_python_yaml.png`

**What should be visible**:
```yaml
- name: Set up Python ${{ matrix.python-version }}
  uses: actions/setup-python@v5
  with:
    python-version: ${{ matrix.python-version }}
    cache: 'pip'
```

---

### Screenshot 11: GitHub Actions Python Setup Step

**What to capture**: The Python setup step in GitHub Actions logs

**Steps**:
1. Back in your browser on the workflow run details page
2. Click on the "build-and-test" job
3. You'll see the job logs
4. Find and expand the "Set up Python" step
5. It should show Python being set up with caching
6. Capture showing:
   - Step name highlighted or expanded
   - Logs showing Python version
   - Cache being used (if applicable)
7. Save as: `task5_07_setup_python_github.png`

**What should be visible**:
- "Set up Python 3.9" (or other version)
- Logs showing setup process
- Cache hit/miss information

---

## TASK 6: DOCKER CONTAINERIZATION (12 Screenshots)

### Screenshot 12: Complete Dockerfile

**What to capture**: The Dockerfile content

**Steps**:
1. In VS Code, open the `Dockerfile`
2. Make sure the entire file is visible (scroll if needed)
3. Capture showing:
   - File name in tab
   - FROM python:3.9-slim
   - LABEL commands
   - ENV variables
   - EXPOSE 8000
   - CMD command
4. You may need to capture in 2 parts if it's too long
5. Save as: `task6_01_dockerfile.png`

**What should be visible**:
```dockerfile
FROM python:3.9-slim
LABEL maintainer="ML App DevOps"
...
EXPOSE 8000
CMD ["python", "src/train.py"]
```

---

### Screenshot 13: .dockerignore File

**What to capture**: The .dockerignore content

**Steps**:
1. In VS Code, open `.dockerignore`
2. Capture showing the file content with exclusions
3. Save as: `task6_02_dockerignore.png`

**What should be visible**:
```
# Python cache
__pycache__
*.pyc
...
# Virtual environments
.venv
venv/
...
```

---

### Screenshot 14: EXPOSE 8000 in Dockerfile

**What to capture**: Close-up of the EXPOSE directive

**Steps**:
1. In VS Code, with Dockerfile open
2. Scroll to the line with `EXPOSE 8000`
3. Capture a focused view showing:
   - The EXPOSE 8000 line
   - A few lines above and below for context
4. Save as: `task6_03_expose_port.png`

**What should be visible**:
```dockerfile
...
RUN mkdir -p models logs

# Expose port for future API
EXPOSE 8000

# Default command
CMD ["python", "src/train.py"]
```

---

### Screenshot 15: docker-compose.yml File

**What to capture**: The docker-compose.yml content

**Steps**:
1. In VS Code, open `docker-compose.yml`
2. Capture showing:
   - File name
   - version: '3.8'
   - All three services (ml-app-train, ml-app-predict, ml-app-test)
3. Save as: `task6_04_docker_compose.png`

**What should be visible**:
```yaml
version: '3.8'

services:
  ml-app-train:
    ...
  ml-app-predict:
    ...
  ml-app-test:
    ...
```

---

### Screenshot 16: Docker Build Command

**What to capture**: Building the Docker image

**Steps**:
1. **IMPORTANT**: Make sure Docker Desktop is running first!
2. In PowerShell terminal, run:
   ```powershell
   docker build -t ml-app:latest .
   ```
3. This will take a few minutes
4. Capture the terminal showing:
   - The build command
   - Build steps being executed (Step 1/X, Step 2/X, etc.)
   - Final "Successfully tagged ml-app:latest" message
5. You may need to capture the beginning and end separately
6. Save as: `task6_05_docker_build.png`

**What should be visible**:
```powershell
PS C:\...\ml-app> docker build -t ml-app:latest .
[+] Building 45.3s (12/12) FINISHED
...
=> => writing image sha256:...
=> => naming to docker.io/library/ml-app:latest
```

---

### Screenshot 17: Docker Images List

**What to capture**: Verifying the image was created

**Steps**:
1. After build completes, run:
   ```powershell
   docker images ml-app
   ```
2. Capture showing:
   - The command
   - Table with REPOSITORY, TAG, IMAGE ID, CREATED, SIZE
   - ml-app listed with latest tag
3. Save as: `task6_06_docker_images.png`

**What should be visible**:
```powershell
PS C:\...\ml-app> docker images ml-app
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
ml-app       latest    abc123def456   30 seconds ago   450MB
```

---

### Screenshot 18: Docker Training Run

**What to capture**: Running training in Docker container

**Steps**:
1. Create models directory if it doesn't exist:
   ```powershell
   mkdir models -ErrorAction SilentlyContinue
   ```
2. Run the Docker container:
   ```powershell
   docker run --rm -v ${PWD}/models:/app/models ml-app:latest
   ```
3. Wait for training to complete (about 10-20 seconds)
4. Capture the terminal showing:
   - The docker run command
   - Full training output
   - "Training completed successfully!"
   - Model saved message
5. May need to scroll to capture all output
6. Save as: `task6_07_docker_training.png`

**What should be visible**:
```
Starting Iris Classifier Training...
Loading Iris dataset...
Successfully loaded Iris dataset
Training set size: 120
Test set size: 30
...
Model Accuracy: 0.9667
...
Training completed successfully!
Model saved to: models/iris_classifier.pkl
```

---

### Screenshot 19: Model File Created

**What to capture**: The trained model file in models directory

**Steps**:
1. After training completes, run:
   ```powershell
   ls models/
   ```
2. Capture showing:
   - The ls command
   - iris_classifier.pkl file listed
3. Save as: `task6_08_model_file.png`

**What should be visible**:
```powershell
PS C:\...\ml-app> ls models/

Directory: C:\...\ml-app\models

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        11/17/2025   X:XX PM           XXXX iris_classifier.pkl
```

---

### Screenshot 20: Docker Predictions

**What to capture**: Running predictions in Docker

**Steps**:
1. Run predictions using the trained model:
   ```powershell
   docker run --rm -v ${PWD}/models:/app/models ml-app:latest python src/predict.py
   ```
2. Capture showing:
   - The command
   - "Model loaded successfully!"
   - All three example predictions
   - Probabilities for each class
3. Save as: `task6_09_docker_predictions.png`

**What should be visible**:
```
Iris Classifier Prediction
Model loaded successfully!

Example Predictions:
...
Example 1: [5.1, 3.5, 1.4, 0.2]
Prediction: setosa
Probabilities:
  setosa: 0.9845
  versicolor: 0.0155
  virginica: 0.0000
...
```

---

### Screenshot 21: Docker Tests

**What to capture**: Running tests in Docker

**Steps**:
1. Run tests in container:
   ```powershell
   docker run --rm ml-app:latest pytest tests/ -v
   ```
2. Capture showing:
   - The command
   - All 6 tests PASSED
   - Final summary
3. Save as: `task6_10_docker_tests.png`

**What should be visible**:
```
====== test session starts ======
platform linux -- Python 3.9.x, pytest-9.0.1
...
tests/test_model.py::TestIrisClassifier::test_model_initialization PASSED
...
====== 6 passed in X.XXs ======
```

---

## FINAL SCREENSHOTS (2 Screenshots)

### Screenshot 22: Final Git Log

**What to capture**: All commits showing completed work

**Steps**:
1. Run:
   ```powershell
   git log --oneline -10
   ```
2. Capture showing all your commits:
   - Docker containerization
   - GitHub Actions CI
   - Flake8 linting
   - Initial commit
3. Save as: `final_01_git_log.png`

**What should be visible**:
```
5c57c2c Add comprehensive homework submission document
526de69 Add Task 6 completion summary
9a952dc Add Docker containerization with enhanced Dockerfile
24e3c6f Add Task 5 completion summary
5c67e0e Add GitHub Actions CI workflow
a1cbd8a Update REPORT.md with linting information
ac53486 Add flake8 linting configuration and fix all style issues
36efae2 Add REPORT.md
fdf7b1e Initial commit
```

---

### Screenshot 23: GitHub Repository Main Page

**What to capture**: Your GitHub repository showing all files

**Steps**:
1. In browser, go to: https://github.com/jasseurchibani/ml-app-devops
2. Make sure you're on the main page (Code tab)
3. Capture showing:
   - Repository name
   - All files listed (Dockerfile, src/, tests/, README.md, etc.)
   - Recent commits
   - Green checkmark next to latest commit (showing CI passed)
4. Save as: `final_02_github_repo.png`

**What should be visible**:
- Repository: jasseurchibani/ml-app-devops
- Branch: main
- Files: Dockerfile, .github/, src/, tests/, requirements.txt, etc.
- Latest commit with green checkmark ✓

---

## Quick Reference: Screenshot Checklist

Copy this checklist and check off as you capture each screenshot:

```
TASK 4 - LINTING & FORMATTING:
[ ] Screenshot 1: .flake8 file content
[ ] Screenshot 2: flake8 with 0 errors
[ ] Screenshot 3: flake8 with statistics
[ ] Screenshot 4: git commit for linting

TASK 5 - GITHUB ACTIONS:
[ ] Screenshot 5: ci.yml workflow file
[ ] Screenshot 6: local pytest passing
[ ] Screenshot 7: GitHub Actions tab
[ ] Screenshot 8: workflow run details
[ ] Screenshot 9: artifacts section
[ ] Screenshot 10: setup-python in YAML
[ ] Screenshot 11: setup-python in GitHub logs

TASK 6 - DOCKER:
[ ] Screenshot 12: Dockerfile content
[ ] Screenshot 13: .dockerignore content
[ ] Screenshot 14: EXPOSE 8000 line
[ ] Screenshot 15: docker-compose.yml
[ ] Screenshot 16: docker build command
[ ] Screenshot 17: docker images output
[ ] Screenshot 18: docker training run
[ ] Screenshot 19: model file created
[ ] Screenshot 20: docker predictions
[ ] Screenshot 21: docker tests

FINAL:
[ ] Screenshot 22: git log showing all commits
[ ] Screenshot 23: GitHub repository page
```

---

## Tips for Good Screenshots

1. **Clear Text**: Make sure terminal text is readable (zoom in if needed)
2. **Full Context**: Include the command AND the output
3. **Relevant Area**: Don't capture unnecessary parts of the screen
4. **Consistent Size**: Try to keep screenshots at similar sizes
5. **File Names**: Use descriptive names as suggested above
6. **Annotations**: You can add arrows or highlights (optional) to emphasize important parts

---

## Inserting Screenshots into HOMEWORK_SUBMISSION.md

After capturing all screenshots:

1. Create an `images/` folder in your project:
   ```powershell
   mkdir images
   ```

2. Move all screenshots into the `images/` folder

3. In the HOMEWORK_SUBMISSION.md file, replace each:
   ```
   **📸 SCREENSHOT X: [Description]**
   ```
   
   With:
   ```markdown
   **Screenshot X: [Description]**
   ![Screenshot X](images/screenshot_name.png)
   ```

Example:
```markdown
**Screenshot 1: .flake8 Configuration File**
![.flake8 config](images/task4_01_flake8_config.png)
```

---

## Need Help?

If Docker Desktop isn't running when you try Docker commands:
1. Open Docker Desktop application
2. Wait for it to fully start (whale icon steady in system tray)
3. Then run your docker commands

If any command doesn't work:
- Make sure you're in the correct directory: `C:\Users\21655\Desktop\CI2\devops\DevOps-MLOps-Labs\session2\ml-app`
- Make sure your virtual environment is activated (you should see `(.venv)` in the prompt)
- Check that all files have been committed to git

---

Good luck with your screenshots! Follow this guide step by step and you'll have everything you need. 🎯
