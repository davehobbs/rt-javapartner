#!/bin/bash

set -eu

CUR_DIR="$(cd $(dirname $0) && pwd)"
pushd "$CUR_DIR/.."

git checkout master

# Set up the information directories
mkdir -p "data"
mkdir -p "logs"

SRC_DIR="src"

# Download the inventory from the different source systems
python3 $SRC_DIR/deliver.py

git add --all
git commit -m "Latest javapartner site delivery"