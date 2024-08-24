#!/bin/bash

# Fail script on error
set -e

# Variables
SQLMESH_REPO="https://github.com/ShivamSoliya/ga4_da_sqlmesh_duckdb.git"
WORKING_DIR="/tmp/project"
DUCKDB_HOME_DIR="/tmp/duckdb_home"

# Install necessary tools
python3 -m venv duck
sudo apt-get install -y git python3-pip

# Create working directory
mkdir -p $WORKING_DIR
cd $WORKING_DIR

# Clone SQLMesh repository
echo "Cloning SQLMesh repository..."
git clone $SQLMESH_REPO sqlmesh

# Install SQLMesh dependencies
echo "Installing SQLMesh dependencies..."
cd sqlmesh
pip install sqlmesh
export PATH=$PATH:/usr/local/bin

# Set up the DuckDB home directory
mkdir -p $DUCKDB_HOME_DIR
export home_directory=$DUCKDB_HOME_DIR

# Run SQLMesh with the specified command
echo "Executing SQLMesh plan..."
sqlmesh --log-to-stdout plan --auto-apply

echo "Job completed successfully."
