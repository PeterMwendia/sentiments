#!/bin/bash

# Define installation paths
MINICONDA_INSTALL_PATH="$HOME/miniconda"
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

# Define environment and requirements file
ENV_NAME="python37env"
REQUIREMENTS_FILE="requirements.txt"

# Download and install Miniconda
mkdir -p "$MINICONDA_INSTALL_PATH"
wget "$MINICONDA_URL" -O miniconda.sh
bash miniconda.sh -b -p "$MINICONDA_INSTALL_PATH"
export PATH="$MINICONDA_INSTALL_PATH/bin:$PATH"
source "$MINICONDA_INSTALL_PATH/etc/profile.d/conda.sh"

# Install Mamba
conda install -y -c conda-forge mamba

# Create Python 3.7 environment
mamba create -n "$ENV_NAME" python=3.7
conda activate "$ENV_NAME"

# Install requirements from a file
mamba install --file "$REQUIREMENTS_FILE"
