#!/bin/bash

# Define the path to the Conda environment
CONDA_PATH="/opt/render/miniconda"
ENV_NAME="python37env"

# Define the path to Conda and Mamba binaries
CONDA_BINARY="$CONDA_PATH/bin/conda"
MAMBA_BINARY="$CONDA_PATH/bin/mamba"

# Define the command to run the app with Gunicorn
GUNICORN_CMD="gunicorn app:app"

# Activate the Conda environment
source "$CONDA_PATH/bin/activate" "$ENV_NAME"
# source "$CONDA_PATH/bin/activate" "$ENV_NAME"

# Run the app using Gunicorn
$GUNICORN_CMD
