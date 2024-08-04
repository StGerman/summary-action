# Source Code Summary Generator

## Purpose
This project provides a tool to generate a summary of the source code changes in a repository. It includes a Makefile to automate the generation of a diff file and a summary of those changes.

## Features
- Generates a diff between the current branch and the `origin/master` branch.
- Creates a summary of the diff using a Python script.

## Getting Started

### Prerequisites
- Python 3.x
- Git
- OpenAI API Key

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/repo-name.git
    cd repo-name
    ```

2. Install the required Python packages:
    ```bash
    pip install openai
    ```

3. Set up the OpenAI API key:
    ```bash
    export OPENAI_API_KEY=your_api_key_here
    ```

### Usage

1. Generate a diff file:
    ```bash
    make diff
    ```

2. Create a summary of the diff:
    ```bash
    make summary
    ```

### Makefile

The Makefile includes the following targets:

- `diff`: Generates a diff between the current branch and the `origin/master` branch and saves it to `diff.txt`.
- `summary`: Depends on the `diff` target and runs a Python script `summary.py` with `diff.txt` as input to create a summary.

### Example

To generate a diff and create a summary, run:

```bash
make summary
```
