#!/bin/bash

set -eu

CUR_DIR="$(cd $(dirname $0) && pwd)"
pushd "$CUR_DIR/.."

git checkout master

# Set up the information directories
mkdir -p "data"
mkdir -p "logs"

SRC_DIR="src"

# Download releases from sources and publish to destinations
python3 $SRC_DIR/deliver.py --action put

git add --all
git commit -m "Latest javapartner site delivery"