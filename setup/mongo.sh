#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo "IIIF API in a Box: Installing MongoDB..."

# Create database directory
mkdir -p /data/db

# Install
apt-get install -y mongodb-org
