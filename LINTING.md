# Linting & Formatting Setup

## Configuration

### Flake8 Configuration (.flake8)
Created `.flake8` configuration file with the following settings:

- **Max line length**: 88 characters (consistent with Black)
- **Excluded directories**: .git, __pycache__, .venv, build, dist, etc.
- **Ignored error codes**:
  - E203: whitespace before ':' (Black compatibility)
  - E266: too many leading '#' for block comment
  - W503: line break before binary operator (Black compatibility)
  - W504: line break after binary operator
- **Max complexity**: 10
- **Shows source code** for each error
- **Statistics enabled**

## Tools Used

### 1. Black (Formatter)
- Auto-formats Python code to be PEP 8 compliant
- Line length: 88 characters
- Already installed via requirements.txt

**Usage:**
```bash
black src/ tests/
```

### 2. Flake8 (Linter)
- Checks Python code for style violations
- Enforces PEP 8 style guide
- Checks for syntax errors and undefined names
- Already installed via requirements.txt

**Usage:**
```bash
# Check specific directories
flake8 src/ tests/

# Check with statistics
flake8 src/ tests/ --statistics

# Check entire project
flake8 .
```

## Code Quality Fixes Applied

### 1. Formatting with Black
- Reformatted all Python files in `src/` and `tests/`
- Fixed indentation and spacing issues
- Standardized line length

### 2. Flake8 Issues Fixed
- ✅ Removed unused imports (sys, os, numpy from predict.py and train.py)
- ✅ Removed unused Optional type from data_loader.py
- ✅ Fixed f-string without placeholders
- ✅ Added proper blank lines between functions (PEP 8: 2 blank lines)
- ✅ Fixed import order in test files
- ✅ Added noqa comments for intentional E402 violations in tests

### Results
**Final Flake8 Check: 0 errors** ✅

## CI/CD Integration

You can integrate these tools into your CI/CD pipeline:

### GitHub Actions Example
```yaml
- name: Lint with flake8
  run: |
    pip install flake8
    flake8 src/ tests/ --count --show-source --statistics

- name: Format check with black
  run: |
    pip install black
    black --check src/ tests/
```

## Pre-commit Hook (Optional)

To run linting before each commit, create `.git/hooks/pre-commit`:

```bash
#!/bin/bash
echo "Running flake8..."
flake8 src/ tests/
if [ $? -ne 0 ]; then
    echo "Flake8 found issues. Please fix them before committing."
    exit 1
fi

echo "Running black..."
black --check src/ tests/
if [ $? -ne 0 ]; then
    echo "Code is not formatted with black. Run 'black src/ tests/' to fix."
    exit 1
fi
```

## Best Practices

1. **Run Black before committing**: `black src/ tests/`
2. **Check with Flake8 regularly**: `flake8 src/ tests/`
3. **Fix issues immediately**: Don't let linting errors accumulate
4. **Use noqa sparingly**: Only when you have a good reason to ignore a rule
5. **Keep configuration consistent**: Don't change .flake8 without team discussion

## References

- [Flake8 Documentation](https://flake8.pycqa.org/)
- [Black Documentation](https://black.readthedocs.io/)
- [PEP 8 Style Guide](https://peps.python.org/pep-0008/)
- [What is Flake8 and Why We Should Use It](https://medium.com/python-pandemonium/what-is-flake8-and-why-we-should-use-it-b89bd78073f2)
