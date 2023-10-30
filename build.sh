# #!/bin/bash

# # Define installation paths
# MINICONDA_INSTALL_PATH="$HOME/miniconda"
# MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

# # Define environment and requirements file
# ENV_NAME="python37env"
# REQUIREMENTS_FILE="requirements.txt"

# # Download and install Miniconda
# mkdir -p "$MINICONDA_INSTALL_PATH"
# wget "$MINICONDA_URL" -O miniconda.sh
# bash miniconda.sh -b -p "$MINICONDA_INSTALL_PATH"
# export PATH="$MINICONDA_INSTALL_PATH/bin:$PATH"
# conda init
# source "$MINICONDA_INSTALL_PATH/etc/profile.d/conda.sh"

# # Install Mamba
# conda install -y -c conda-forge mamba

# # Create Python 3.7 environment
# mamba create -n "$ENV_NAME" python=3.7
# conda activate "$ENV_NAME"

# # Install requirements from a file
# mamba install --file "$REQUIREMENTS_FILE"
#!/bin/bash

# Define installation paths
MINICONDA_INSTALL_PATH="$HOME/miniconda"
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

# Define environment and requirements file
ENV_NAME="python37env"
REQUIREMENTS_FILE="requirements.txt"

# Download and install Miniconda only if it doesn't exist
if [ ! -d "$MINICONDA_INSTALL_PATH" ]; then
    mkdir -p "$MINICONDA_INSTALL_PATH"
    wget "$MINICONDA_URL" -O miniconda.sh
    bash miniconda.sh -b -p "$MINICONDA_INSTALL_PATH"
fi

# Use the conda binary from the Miniconda installation
CONDA_BINARY="$MINICONDA_INSTALL_PATH/bin/conda"

# Check if conda is installed
if [ ! -f "$CONDA_BINARY" ]; then
    echo "Error: conda binary not found. Ensure Miniconda installation is correct."
    exit 1
fi

# Use the mamba binary from the Miniconda installation
MAMBA_BINARY="$MINICONDA_INSTALL_PATH/bin/mamba"

# Check if mamba is installed, if not, install it using conda
if [ ! -f "$MAMBA_BINARY" ]; then
    "$CONDA_BINARY" install -y -c conda-forge mamba
fi

# Activate the Miniconda environment
source "$MINICONDA_INSTALL_PATH/etc/profile.d/conda.sh"

# Create Python 3.7 environment using mamba
"$MAMBA_BINARY" create -n "$ENV_NAME" python=3.7

# Activate the environment
source "$MINICONDA_INSTALL_PATH/bin/activate" "$ENV_NAME"

# Install requirements from a file using mamba
"$MAMBA_BINARY" --no-plugins install --file "$REQUIREMENTS_FILE"
