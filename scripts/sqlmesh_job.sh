#!/bin/bash

# Fail script on error
set -e

# Variables
SQLMESH_REPO="https://github.com/ShivamSoliya/ga4_da_sqlmesh_duckdb.git"
WORKING_DIR="/tmp/project"

# Install necessary tools
sudo apt-get install -y git python3-pip

# Create working directory
mkdir -p $WORKING_DIR
cd $WORKING_DIR

# Clone SQLMesh repository
echo "Cloning SQLMesh repository..."
git clone $SQLMESH_REPO sqlmesh

# Install SQLMesh dependencies
echo "Installing SQLMesh dependencies..."
export PATH=$PATH:/usr/local/bin
cd sqlmesh
pip3 install sqlmesh

# Set up the DuckDB home directory
echo "Home:$HOME"
mkdir -p $WORKING_DIR
export HOME=$WORKING_DIR
echo "Home:$HOME"

# Run SQLMesh with the specified command
echo "Executing SQLMesh plan..."
sqlmesh --log-to-stdout plan --auto-apply

echo "Job completed successfully."
