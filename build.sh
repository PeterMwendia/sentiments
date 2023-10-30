#!/bin/bash

# Define Conda and Mamba paths
CONDA_PATH="/opt/render/miniconda"
CONDA_BINARY="$CONDA_PATH/bin/conda"
MAMBA_BINARY="$CONDA_PATH/bin/mamba"

# Define environment and requirements file
ENV_NAME="python37env"
REQUIREMENTS_FILE="requirements.txt"

# Check if Conda exists in the specified directory
if [ -f "$CONDA_BINARY" ]; then
    # Check if Mamba is installed
    if [ -f "$MAMBA_BINARY" ]; then
        echo "Mamba is already installed."
    else
        echo "Mamba not found. Installing Mamba..."
        "$CONDA_BINARY" install -y -c conda-forge mamba
    fi

    # Activate the Miniconda environment
    source "$CONDA_PATH/etc/profile.d/conda.sh"
else
    echo "Conda not found in the specified directory. Removing any existing installation..."

    # Clean up the Miniconda installation directory if it exists
    if [ -d "$CONDA_PATH" ]; then
        rm -rf "$CONDA_PATH"
    fi

    echo "Downloading and installing Miniconda..."
    
    # Download and install Miniconda
    mkdir -p "$CONDA_PATH"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    bash miniconda.sh -b -p "$CONDA_PATH"
    source "$CONDA_PATH/etc/profile.d/conda.sh"

    # Install Mamba
    "$CONDA_BINARY" install -y -c conda-forge mamba
fi

# Create Python 3.7 environment using Mamba
"$MAMBA_BINARY" create -n "$ENV_NAME" python=3.7

# Activate the environment
source "$CONDA_PATH/bin/activate" "$ENV_NAME"

# Install requirements from a file using Mamba
"$MAMBA_BINARY" install --file "$REQUIREMENTS_FILE"


